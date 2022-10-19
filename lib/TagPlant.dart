import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class tagplant extends StatefulWidget {
  final String tgfname;
  final String tgemail;
  final String tghome;
  final String tgcon;
  final String tgpname;
  final String tgpdesc;
  tagplant({
    required this.tgfname,
    required this.tgemail,
    required this.tghome,
    required this.tgcon,
    required this.tgpname,
    required this.tgpdesc,
  });

  @override
  State<tagplant> createState() => _tagplantState();
}

class _tagplantState extends State<tagplant> {

  String latitude = '';
  String longitude = '';
  String country = "";
  String locality = "";
  String postalcode = "";
  String street = "";
  double intlatitude = 0;
  double intlongitude = 0;

  late TextEditingController useremail;
  late TextEditingController plantname;
  late TextEditingController planthomeadd;

  @override
  void initState() {
    useremail = TextEditingController(text: widget.tgemail);
    plantname = TextEditingController(text: widget.tgpname);
    planthomeadd = TextEditingController(text: widget.tghome);
    super.initState();
  }

  Future tagplant(String name) async {
    try{
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission==LocationPermission.denied || permission==LocationPermission.deniedForever){
          Future.error('Location Permissions are denied');
          Fluttertoast.showToast(
            backgroundColor: Colors.green.shade900,
            textColor: Colors.white,
            msg: 'Location Permission is Denied',
            toastLength: Toast.LENGTH_SHORT,
          );
          return Navigator.pop(context);
        }
      }else{
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);

        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        street = placemarks[0].street.toString();
        country = placemarks[0].country.toString();
        locality = placemarks[0].locality.toString();
        postalcode = placemarks[0].postalCode.toString();

        var url = Uri.http("plantmedicfinder.rf.gd", '/system/addtagplant.php', {'q': '{http}'});
        var response = await http.post(url, body: {
          "uem": useremail.text,
          "pn": plantname.text,
          "ph": planthomeadd.text,
          "ploc": "${street}${locality}${postalcode}${country}",
          "plat": latitude,
          "plong": longitude,
        });
        var data = json.decode(response.body);
        if (data == "Error") {
          Fluttertoast.showToast(
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            msg: '${name} is already tagged',
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Fluttertoast.showToast(
            backgroundColor: Colors.green.shade900,
            textColor: Colors.white,
            msg: '${name} is successfully added',
            toastLength: Toast.LENGTH_SHORT,
          );
        }

        setState(() {
          intlatitude = position.latitude;
          intlongitude = position.longitude;
          latitude = latitude;
          longitude = longitude;
          country = country;
          locality = locality;
          postalcode = postalcode;
          street = street;
        });
      }
    }catch(e){
      print(e);
    }
  }

  void googleMap(double latitude,double longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 30),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text("Tag this Plant with"),
            Text("your Current Location"),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade900,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: TextField(controller: useremail),
              ),
              Visibility(
                visible: false,
                child: TextField(controller: plantname),
              ),
              Visibility(
                visible: false,
                child: TextField(controller: planthomeadd),
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  if(plantname.text=="Akapulko")
                    Image(
                      image: AssetImage('assets/images/acapulco.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Ampalaya")
                    Image(
                      image: AssetImage('assets/images/ampalaya.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Bawang")
                    Image(
                      image: AssetImage('assets/images/bawang.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Bayabas")
                    Image(
                      image: AssetImage('assets/images/bayabas.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Lagundi")
                    Image(
                      image: AssetImage('assets/images/lagundi.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Niyug-Nyogan")
                    Image(
                      image: AssetImage('assets/images/niyugniyogan.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Sambong")
                    Image(
                      image: AssetImage('assets/images/sambong.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Tsaang Gubat")
                    Image(
                      image: AssetImage('assets/images/tsaanggubat.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Ulasimang Bato")
                    Image(
                      image: AssetImage('assets/images/ulasimangbato.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text=="Yerba-Buena")
                    Image(
                      image: AssetImage('assets/images/yerbabuena.jpg'),
                      height: 280.0,
                      width: 250.0,
                    ),
                  if(plantname.text!="Akapulko" ||
                      plantname.text!="Ampalaya" ||
                      plantname.text!="Bawang" ||
                      plantname.text!="Bayabas" ||
                      plantname.text!="Lagundi" ||
                      plantname.text!="Niyug-Niyogan" ||
                      plantname.text!="Sambong" ||
                      plantname.text!="Tsaang Gubat" ||
                      plantname.text!="Ulamisang Bato" ||
                      plantname.text!="Yerba-Buena"
                  )Visibility(
                    visible: plantname.text=="Akapulko" ||
                        plantname.text=="Ampalaya" ||
                        plantname.text=="Bawang" ||
                        plantname.text=="Bayabas" ||
                        plantname.text=="Lagundi" ||
                        plantname.text=="Niyug-Niyogan" ||
                        plantname.text=="Sambong" ||
                        plantname.text=="Tsaang Gubat" ||
                        plantname.text=="Ulasimang Bato" ||
                        plantname.text=="Yerba-Buena"
                        ? false
                        : true ,
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/images/app_logo.png'),height: 280.0,width: 250.0,),
                        SizedBox(height: 15.0),
                        Text('New Medicinal Plant approved by DOH'),
                        Text('Image of this plant soon will be uploaded'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RaisedButton(
                  child: Text("Tag", style: TextStyle(color: Colors.white, fontSize: 25),),
                  padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                  color: Colors.green.shade900,
                  onPressed: (){
                    tagplant(plantname.text);
                  }
              ),
              SizedBox(height: 15),
              Visibility(
                visible: country == "" ? false : true,
                child: Column(
                  children: [
                    Text("Street: ${street}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text("Locality: ${locality}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text("PostalCode: ${postalcode}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text("Country: ${country}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Check your Current Location',style: TextStyle(fontSize: 20),),
                    Text('Here:',style: TextStyle(fontSize: 20),),
                    RaisedButton(
                        child: Text("Show on Map", style: TextStyle(color: Colors.white, fontSize: 20),),
                        color: Colors.green.shade900,
                        onPressed: (){
                          googleMap(intlatitude,intlongitude);
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

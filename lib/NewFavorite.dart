import 'dart:convert';

import 'package:capstone/tabs/FavoriteTab.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class newfavorite extends StatefulWidget {
  final String nffname;
  final String nfemail;
  final String nfhome;
  final String nfcon;
  final String nfpname;
  final String nfpdesc;
  newfavorite({
    required this.nffname,
    required this.nfemail,
    required this.nfhome,
    required this.nfcon,
    required this.nfpname,
    required this.nfpdesc,
  });

  @override
  State<newfavorite> createState() => _newfavoriteState();
}

class _newfavoriteState extends State<newfavorite> {

  late TextEditingController useremail;
  late TextEditingController plantname;
  late TextEditingController planthomeadd;
  late TextEditingController plantdescription;

  @override
  void initState() {
    useremail = TextEditingController(text: widget.nfemail);
    plantname = TextEditingController(text: widget.nfpname);
    planthomeadd = TextEditingController(text: widget.nfhome);
    plantdescription = TextEditingController(text: widget.nfpdesc);
    super.initState();
  }

  Future addnewfavoriteplant(String name) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/addfavorite.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "uem": useremail.text,
        "pn": plantname.text,
        "ph": planthomeadd.text,
        "pd": plantdescription.text,
      });
      var data = json.decode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: '${name} is already added',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${name} is successfully added',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => favoritetab(
              ftfname: widget.nffname,
              ftemail: widget.nfemail,
              fthome: widget.nfhome,
              ftcon: widget.nfcon,
            ),
          ),
        );
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,size: 30),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text('Add to your Favorite'),
          centerTitle: true,
          backgroundColor: Colors.green.shade900,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(plantname.text,style: TextStyle(fontSize: 24.0),),
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
              Visibility(
                visible: false,
                child: TextField(controller: plantdescription),
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
                  if(plantname.text=="Niyug-Niyogan")
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
                  child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 25),),
                  padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                  color: Colors.green.shade900,
                  onPressed: (){
                    addnewfavoriteplant(plantname.text);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

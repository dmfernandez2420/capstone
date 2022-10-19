import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class availablelocations extends StatefulWidget {
  final String alfname;
  final String alemail;
  final String alhome;
  final String alcon;
  final String albyuser;
  final String alpname;
  final String alpdesc;
  availablelocations({
    required this.alfname,
    required this.alemail,
    required this.alhome,
    required this.alcon,
    required this.albyuser,
    required this.alpname,
    required this.alpdesc,
  });

  @override
  State<availablelocations> createState() => _availablelocationsState();
}

class _availablelocationsState extends State<availablelocations> {

  Future<List> getData() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/apptagplant.php'); //Api Link
    var data = {'plant': widget.alpname};
    final response = await http.post(url,body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        backgroundColor: Colors.green.shade900,
        title: Text('Available Places'),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx,ss) {
          if(ss.hasError){
            print("error");
          }
          if(ss.hasData){
            return Items(list:ss.data!);
          }
          else{
            return Center(
              child: Text('No Locations Yet',style: TextStyle(fontSize: 30,color: Colors.red)),
            );
          }
        },
      ),
    );
  }
}
class Items extends StatelessWidget {
  List list;
  Items({Key? key, required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list==null?0:list.length,
        itemBuilder: (ctx,i){
          return Card(
            elevation: 10.0,
            shadowColor: Colors.lightBlueAccent,
            color: Colors.lightGreen,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              leading: Text(list[i]['p_name'],style: TextStyle(color: Colors.black,fontSize: 20.0),),
              title: Text(list[i]['user_email'],style: TextStyle(color: Colors.black,fontSize: 20.0),),
              subtitle: Column(
                children: [
                  Divider(),
                  Text(list[i]['p_homeadd'],style: TextStyle(color: Colors.black,fontSize: 20.0),),
                  Divider(),
                  Text(list[i]['p_location'],style: TextStyle(color: Colors.black,fontSize: 20.0),),
                ],
              ),
              onTap: (){
                googleMap(list[i]['p_latitude'],list[i]['p_longitude']);
              },
            ),
          );
        }
    );
  }
}

void googleMap(double latitude,double longitude) async {
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
      }else{
        String googleUrl =
            "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

        if (await canLaunch(googleUrl) != null) {
          await launch(googleUrl);
        } else
          throw ("Couldn't open google maps");
      }
    }else{
      String googleUrl =
          "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

      if (await canLaunch(googleUrl) != null) {
        await launch(googleUrl);
      } else
        throw ("Couldn't open google maps");
    }
  }catch(e){
    print(e);
  }
}
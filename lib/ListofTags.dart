import 'dart:convert';

import 'package:capstone/DashPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class listoftags extends StatefulWidget {
  final String ltfname;
  final String ltem;
  final String lthome;
  final String ltcon;
  listoftags({
    required this.ltfname,
    required this.ltem,
    required this.lthome,
    required this.ltcon,
  });

  @override
  State<listoftags> createState() => _listoftagsState(
      lotfname: ltfname, lotem: ltem, lothome: lthome, lotcon: ltcon);
}

class _listoftagsState extends State<listoftags> {
  final String lotfname;
  final String lotem;
  final String lothome;
  final String lotcon;
  _listoftagsState({
    required this.lotfname,
    required this.lotem,
    required this.lothome,
    required this.lotcon,
  });

  Future<List> appuserstagplants() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/appuserstagplants.php'); //Api Link
    var data = {'useremail': lotem};
    final response = await http.post(url,body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  @override
  void initState() {
    appuserstagplants();
    super.initState();
  }

  Future deletefavoriteplant(int idplant,String pname) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appdeletetag.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "deleteid": idplant.toString(),
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${pname} has been Removed',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => listoftags(
              ltfname: lotfname,
              ltem: lotem,
              lthome: lothome,
              ltcon: lotcon,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Unsuccessful Deleting',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }catch(e){
      print(e);
    }
  }

  void myAlert(int idplant,String plname){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Do you really want to remove this favorite plant?',textAlign: TextAlign.center),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(plname,style: TextStyle(fontSize: 28.0),),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.red,
                        label: const Text('Remove'),
                        icon: const Icon(Icons.delete_forever_rounded),
                        onPressed: (){
                          deletefavoriteplant(idplant,plname);
                        },
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.orange,
                        label: const Text('Cancel'),
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: lotfname,
          dashem: lotem,
          dashhome: lothome,
          dashcon: lotcon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade900,
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text('List of your Tags'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
                dashfname: lotfname,
                dashem: lotem,
                dashhome: lothome,
                dashcon: lotcon,
              )));
            },
          ),
        ),
        body: FutureBuilder<List>(
          future: appuserstagplants(),
          builder: (ctx,ss) {
            if(ss.hasError){
              print("error");
            }
            if(ss.hasData){
              List list = ss.data!;
              return ListView.builder(
                  itemCount: list==null?0:list.length,
                  itemBuilder: (ctx,i){
                    return Card(
                      elevation: 10.0,
                      shadowColor: Colors.lightBlueAccent,
                      color: Colors.lightGreen,
                      margin: EdgeInsets.all(5.0),
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        leading: Icon(Icons.label_important_outline,size: 35),
                        title: Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(list[i]['p_name'],style: TextStyle(color: Colors.black,fontSize: 20.0),),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_forever,size: 40),
                          onPressed: (){
                            myAlert(list[i]['id'],list[i]['p_name']);
                          },
                        ),
                      ),
                    );
                  }
              );
            }
            else{
              return Center(
                child: Text('No Tags Yet',style: TextStyle(fontSize: 30,color: Colors.red)),
              );
            }
          },
        ),
      ),
    );
  }
}

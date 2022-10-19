import 'dart:convert';
import 'dart:io';
import 'package:capstone/DashPage.dart';
import 'package:capstone/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class listofuploads extends StatefulWidget {
  final String lufname;
  final String luem;
  final String luhome;
  final String lucon;
  listofuploads({
    required this.lufname,
    required this.luem,
    required this.luhome,
    required this.lucon,
  });

  @override
  State<listofuploads> createState() => _listofuploadsState(
      loufname: lufname, louem: luem, louhome: luhome, loucon: lucon);
}

class _listofuploadsState extends State<listofuploads> {
  final String loufname;
  final String louem;
  final String louhome;
  final String loucon;
  _listofuploadsState({
    required this.loufname,
    required this.louem,
    required this.louhome,
    required this.loucon,
  });

  Future deleteuploadplant(int idplant,String pname) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appdeleteupload.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "deleteid": idplant.toString(),
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${pname} has been Deleted',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => listofuploads(
              lufname: loufname,
              luem: louem,
              luhome: louhome,
              lucon: loucon,
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
  void alertdelete(String idplant,String plname){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Do you really want to delete this uploaded plant?',textAlign: TextAlign.center),
            content: Container(
              height: 400,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(plname,style: TextStyle(fontSize: 28.0),),
                  SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      if(plname=="Akapulko")
                        Image(
                          image: AssetImage('assets/images/acapulco.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Ampalaya")
                        Image(
                          image: AssetImage('assets/images/ampalaya.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Bawang")
                        Image(
                          image: AssetImage('assets/images/bawang.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Bayabas")
                        Image(
                          image: AssetImage('assets/images/bayabas.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Lagundi")
                        Image(
                          image: AssetImage('assets/images/lagundi.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Niyug-Niyogan")
                        Image(
                          image: AssetImage('assets/images/niyugniyogan.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Sambong")
                        Image(
                          image: AssetImage('assets/images/sambong.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Tsaang Gubat")
                        Image(
                          image: AssetImage('assets/images/tsaanggubat.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Ulasimang Bato")
                        Image(
                          image: AssetImage('assets/images/ulasimangbato.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname=="Yerba-Buena")
                        Image(
                          image: AssetImage('assets/images/yerbabuena.jpg'),
                          height: 230.0,
                          width: 230.0,
                        ),
                      if(plname!="Akapulko" ||
                          plname!="Ampalaya" ||
                          plname!="Bawang" ||
                          plname!="Bayabas" ||
                          plname!="Lagundi" ||
                          plname!="Niyug-Niyogan" ||
                          plname!="Sambong" ||
                          plname!="Tsaang Gubat" ||
                          plname!="Ulamisang Bato" ||
                          plname!="Yerba-Buena"
                      )Visibility(
                        visible: plname=="Akapulko" ||
                            plname=="Ampalaya" ||
                            plname=="Bawang" ||
                            plname=="Bayabas" ||
                            plname=="Lagundi" ||
                            plname=="Niyug-Niyogan" ||
                            plname=="Sambong" ||
                            plname=="Tsaang Gubat" ||
                            plname=="Ulasimang Bato" ||
                            plname=="Yerba-Buena"
                            ? false
                            : true ,
                        child: Column(
                          children: [
                            Image(image: AssetImage('assets/images/app_logo.png'),height: 230.0,width: 230.0,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.red,
                        label: const Text('Delete'),
                        icon: const Icon(Icons.delete_forever_rounded),
                        onPressed: (){
                          deleteuploadplant(int.parse(idplant),plname);
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

  Future updateplantname(int idplant,String pname) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appupdateuploadplantname.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "upid": idplant.toString(),
        "uppname": pname,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${pname} has been Updated',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => listofuploads(
              lufname: loufname,
              luem: louem,
              luhome: louhome,
              lucon: loucon,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Unsuccessful Updating',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }catch(e){
      print(e);
    }
  }
  void editplantname(int idplant,String plname){
    TextEditingController plnamecontrol = TextEditingController(text: plname);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Update(Name)',textAlign: TextAlign.center),
            content: Container(
              height: 140,
              child: Column(
                children: [
                  TextField(
                    controller: plnamecontrol,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 50,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.green.shade900,
                        label: const Text('Update'),
                        icon: const Icon(Icons.system_update),
                        onPressed: (){
                          updateplantname(idplant,plnamecontrol.text);
                        },
                      ),
                      SizedBox(height: 15),
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

  Future updateplantdesc(int idplant,String pname,String pdesc) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appupdateuploadplantdesc.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "upid": idplant.toString(),
        "updesc": pdesc,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${pname} has been Updated',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => listofuploads(
              lufname: loufname,
              luem: louem,
              luhome: louhome,
              lucon: loucon,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Unsuccessful Updating',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }catch(e){
      print(e);
    }
  }
  void editplantdescription(int idplant,String plname){
    TextEditingController pldesccontrol = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Update(Description)',textAlign: TextAlign.center),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  TextField(
                    controller: pldesccontrol,
                    textAlign: TextAlign.justify,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 50,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.green.shade900,
                        label: const Text('Update'),
                        icon: const Icon(Icons.system_update),
                        onPressed: (){
                          if(pldesccontrol.text!=""){
                            updateplantdesc(idplant,plname,pldesccontrol.text);
                          } else{
                            Fluttertoast.showToast(
                              backgroundColor: Colors.orange,
                              textColor: Colors.white,
                              msg: 'Please put some short Descriptions',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 15),
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

  void alertedit(String idplant,String plname){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Choose which one do you want to update:',textAlign: TextAlign.center),
            content: Container(
              height: 210,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.green.shade900,
                    label: const Text('Name of Plant'),
                    icon: const Icon(Icons.title),
                    onPressed: (){
                      editplantname(int.parse(idplant),plname);
                    },
                  ),
                  SizedBox(height: 15),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.green.shade900,
                    label: const Text('Description of Plant'),
                    icon: const Icon(Icons.subtitles_outlined),
                    onPressed: (){
                      editplantdescription(int.parse(idplant),plname);
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(height: 15),
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
            ),
          );
        }
    );
  }

  late bool searching;
  late bool error;
  late String query;
  var data;
  String dataurl = "http://plantmedicfinder.rf.gd/system/search_suggestion.php";

  void getSuggestion() async{
    var res = await http.post(Uri.parse("$dataurl?query=${Uri.encodeComponent(query)}"));

    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
      });
    }else{
      setState(() {
        error = true;
      });
    }
  }

  @override
  void initState() {
    searching = true;
    error = false;
    query = "";
    getSuggestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: loufname,
          dashem: louem,
          dashhome: louhome,
          dashcon: loucon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text('List of your Uploads'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
                dashfname: loufname,
                dashem: louem,
                dashhome: louhome,
                dashcon: loucon,
              )));
            },
          ),
        ),
        body: SingleChildScrollView(
          child:Container(
              alignment: Alignment.center,
              child:data == null
                  ? Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 235.0),
                  Text('No Data Found',style: TextStyle(fontSize: 30,color: Colors.red)),
                  SizedBox(height: 15.0),
                  Text('Please Check your Internet Connection',style: TextStyle(fontSize: 30,color: Colors.red),textAlign: TextAlign.center,)
                ],
              )
                  : showSearchSuggestions()
          ),
        ),
      ),
    );
  }

  Widget showSearchSuggestions(){
    List suggestionlist = List.from(data["data"].map((i){
      return SearchSuggestion.fromJSON(i);
    })
    );

    return SingleChildScrollView(
      child: Column(
        children:suggestionlist.map((suggestion){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.lightBlueAccent,
              color: Colors.green,
              margin: EdgeInsets.all(5.0),
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                tileColor: Colors.lightGreen,
                trailing: Container(
                  width: 98.0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          alertedit(suggestion.id.toString(),suggestion.pname);
                        },
                        icon: Icon(Icons.edit,size: 35),
                      ),
                      IconButton(
                        onPressed: (){
                          alertdelete(suggestion.id.toString(),suggestion.pname);
                        },
                        icon: Icon(Icons.delete_forever,size: 35),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  print(suggestion.id);
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => SecondScreenState(
                      suggestion.id.toString(), loufname, louem, louhome, loucon)));
                },
                title: Text(suggestion.pname, style: TextStyle(fontSize:24, fontWeight:FontWeight.normal),),
                leading: Icon(Icons.grass,size: 35.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'dart:convert';
import 'package:capstone/tabs/AccountTab.dart';
import 'package:capstone/tabs/FavoriteTab.dart';
import 'package:capstone/tabs/UploadTab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DashPage.dart';

class listofappusers extends StatefulWidget {
  final String laufname;
  final String lauem;
  final String lauhome;
  final String laucon;
  listofappusers({
    required this.laufname,
    required this.lauem,
    required this.lauhome,
    required this.laucon,
  });

  @override
  State<listofappusers> createState() => _listofappusersState(
      loaufname: laufname, loauem: lauem, loauhome: lauhome, loaucon: laucon
  );
}

class _listofappusersState extends State<listofappusers> {
  final String loaufname;
  final String loauem;
  final String loauhome;
  final String loaucon;
  _listofappusersState({
    required this.loaufname,
    required this.loauem,
    required this.loauhome,
    required this.loaucon,
  });

  Future<List> getData() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/appusersaccount.php'); //Api Link
    final response = await http.post(url);
    return jsonDecode(response.body);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future updateaccount(int id,String fu,String pass,String em,String ho,String con) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appupdateusersaccount.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "upid": id.toString(),
        "upfname": fu,
        "uppass": pass,
        "upemail": em,
        "uphome": ho,
        "upcontact": con
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
          msg: '${fu} has been Updated',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => listofappusers(
              laufname: loaufname,
              lauem: loauem,
              lauhome: loauhome,
              laucon: loaucon,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: loaufname,
          dashem: loauem,
          dashhome: loauhome,
          dashcon: loaucon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text("List of App User's Accounts"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
                dashfname: loaufname,
                dashem: loauem,
                dashhome: loauhome,
                dashcon: loaucon,
              )));
            },
          ),
        ),
        body: FutureBuilder<List>(
          future: getData(),
          builder: (ctx,ss) {
            if(ss.hasError){
              print("error");
            }
            if(ss.hasData){
              List list = ss.data!;
              return ListView.builder(
                  itemCount: list==null?0:list.length,
                  itemBuilder: (ctx,i){
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Colors.lightBlueAccent,
                        color: Colors.green,
                        margin: EdgeInsets.all(5.0),
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                          tileColor: Colors.lightGreen,
                          trailing: Container(
                            width: 98.0,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.edit,size: 35),
                                ),
                                IconButton(
                                  onPressed: (){
                                    //alertdelete(suggestion.id.toString(),suggestion.pname);
                                  },
                                  icon: Icon(Icons.delete_forever,size: 35),
                                ),
                              ],
                            ),
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              list[i]['email_address']=="plantmedicfinderadmin@gmail.com"
                                  ? Image(image: AssetImage('assets/images/admin.png'),
                                  height: 38.0,
                                  width: 38.0)
                                  : Image(image: AssetImage('assets/images/user.png'),
                                  height: 38.0,
                                  width: 38.0),
                            ],
                          ),
                          title: Text(list[i]['full_name']), //Key
                          subtitle: Text(list[i]['email_address']), //Key
                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>appusersdetails(
                              list[i]['id'].toString(), loaufname,loauem, loauhome, loaucon)
                          )),
                        ),
                      ),
                    );
                  }
              );
            }
            else{
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class appusersdetails extends StatefulWidget {
  final String idHolder;
  final String audfname;
  final String audem;
  final String audhome;
  final String audcon;
  appusersdetails(this.idHolder,this.audfname,this.audem,this.audhome,this.audcon);

  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder,this.audfname,this.audem,this.audhome,this.audcon);
  }
}

class SecondScreen extends State<appusersdetails> {
  final String idHolder;
  final String dfname;
  final String ddem;
  final String ddhome;
  final String ddcon;

  SecondScreen(this.idHolder,this.dfname,this.ddem,this.ddhome,this.ddcon);

  Future<List> fetchplant() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/getaccount.php'); //Api Link
    var data = {'id': int.parse(idHolder)};
    final response = await http.post(url,body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  @override
  void initState() {
    fetchplant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => listofappusers(
          laufname: dfname,
          lauem: ddem,
          lauhome: ddhome,
          laucon: ddcon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade900,
        appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: 200.0,
          title: Column(
            children: [
              Text("Plant Medic Finder",
                style: TextStyle(
                  fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(dfname,
                style: TextStyle(
                    fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white
                ),
              ),
              Text(ddem,
                style: TextStyle(
                    fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.white
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_box_outlined,size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Selected App User's",style: TextStyle(fontSize: 20.0),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 40.0),
                  Text("Account",style: TextStyle(fontSize: 20.0),),
                ],
              ),
            ],
          ),
          leading: Image(
            image: AssetImage('assets/images/capspic.png'),
            height: 70.0,
            width: 70.0,
          ),
          actions: [
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
                      dashfname: dfname,
                      dashem: ddem,
                      dashhome: ddhome,
                      dashcon: ddcon,
                    )));
                  },
                  icon: Icon(Icons.home_outlined,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => favoritetab(
                      ftfname: dfname,
                      ftemail: ddem,
                      fthome: ddhome,
                      ftcon: ddcon,
                    )));
                  },
                  icon: Icon(Icons.favorite,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    if(ddem=="plantmedicfinderadmin@gmail.com"){
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => uploadtab(
                        utfname: dfname,
                        utemail: ddem,
                        uthome: ddhome,
                        utcon: ddcon,
                      )));
                    }else{
                      showDialog(
                          context: context,
                          builder:(BuildContext context){
                            return AlertDialog(
                              backgroundColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              title: Center(child: Text('Alert',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0))),
                              content: Container(
                                height: 120.0,
                                child: Column(
                                  children: [
                                    Text('Sorry, Only Admin can upload Medicinal Plant that approved by DOH.',textAlign: TextAlign.center,),
                                    SizedBox(height: 15.0),
                                    FloatingActionButton.extended(
                                      backgroundColor: Colors.orange,
                                      label: const Text('OK'),
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
                  },
                  icon: Icon(Icons.upload_outlined,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => accounttab(
                      atfname: dfname,
                      atemail: ddem,
                      athome: ddhome,
                      atcon: ddcon,
                    )));
                  },
                  icon: Column(
                    children: [
                      if(ddem=="plantmedicfinderadmin@gmail.com")
                        Image(
                          image: AssetImage('assets/images/admin.png'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(ddem=="fdanmerick@gmail.com")
                        Image(
                          image: AssetImage('assets/images/dmf.jpg'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(ddem!="plantmedicfinderadmin@gmail.com" ||
                          ddem!="fdanmerick@gmail.com"
                      )Visibility(
                        visible: ddem=="plantmedicfinderadmin@gmail.com" ||
                            ddem=="fdanmerick@gmail.com"
                            ? false
                            : true ,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/images/user.png'),
                              height: 32.0,
                              width: 32.0,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: FutureBuilder<List>(
          future: fetchplant(),
          builder: (ctx,ss) {
            if(ss.hasError){
              print("error");
            }
            if(ss.hasData){
              List list = ss.data!;
              return ListView.builder(
                  itemCount: list==null?0:list.length,
                  itemBuilder: (ctx,i){
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        color: Colors.lightGreen,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15.0),
                            Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text('Full Name:',style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.0),
                                Text(list[i]['full_name'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text('Password:',style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.0),
                                Text(list[i]['pass_word'].toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text('Email Address:',style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.0),
                                Text(list[i]['email_address'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text('Home Address:',style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.0),
                                Expanded(child: Text(list[i]['home_address'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text('Contact Number:',style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.0),
                                Text(list[i]['contact_number'].toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            else{
              return Center(
                child: Text('No Data has been Found',style: TextStyle(fontSize: 30,color: Colors.red)),
              );
            }
          },
        ),
      ),
    );
  }
}
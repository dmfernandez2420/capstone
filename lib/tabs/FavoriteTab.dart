import 'dart:convert';

import 'package:capstone/AvailableLocations.dart';
import 'package:capstone/DashPage.dart';
import 'package:capstone/NewFavorite.dart';
import 'package:capstone/TagPlant.dart';
import 'package:capstone/tabs/AccountTab.dart';
import 'package:capstone/tabs/UploadTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class favoritetab extends StatefulWidget {
  final String ftfname;
  final String ftemail;
  final String fthome;
  final String ftcon;
  favoritetab({
    required this.ftfname,
    required this.ftemail,
    required this.fthome,
    required this.ftcon,
  });

  @override
  State<favoritetab> createState() => _favoritetabState();
}

class _favoritetabState extends State<favoritetab> {

  Future<List> fetchfavoriteplant() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/appgetfavoriteplantinfo.php'); //Api Link
    var data = {'useremail': widget.ftemail};
    final response = await http.post(url,body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  @override
  void initState() {
    fetchfavoriteplant();
    super.initState();
  }

  gotonextactivity(BuildContext context, int dataHolder) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SecondActivity(dataHolder.toString(),
            widget.ftfname, widget.ftemail, widget.fthome, widget.ftcon)));
  }

  Future deletefavoriteplant(int idplant,String pname) async {
    try{
      var url = Uri.http("plantmedicfinder.rf.gd", '/system/appdeletefavorite.php', {'q': '{http}'});
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
            builder: (context) => favoritetab(
              ftfname: widget.ftfname,
              ftemail: widget.ftemail,
              fthome: widget.fthome,
              ftcon: widget.ftcon,
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
              height: 338,
              child: Column(
                children: [
                  Column(
                    children: <Widget>[
                      if(plname=="Akapulko")
                        Image(
                          image: AssetImage('assets/images/acapulco.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Ampalaya")
                        Image(
                          image: AssetImage('assets/images/ampalaya.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Bawang")
                        Image(
                          image: AssetImage('assets/images/bawang.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Bayabas")
                        Image(
                          image: AssetImage('assets/images/bayabas.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Lagundi")
                        Image(
                          image: AssetImage('assets/images/lagundi.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Niyug-Nyogan")
                        Image(
                          image: AssetImage('assets/images/niyugniyogan.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Sambong")
                        Image(
                          image: AssetImage('assets/images/sambong.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Tsaang Gubat")
                        Image(
                          image: AssetImage('assets/images/tsaanggubat.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Ulasimang Bato")
                        Image(
                          image: AssetImage('assets/images/ulasimangbato.jpg'),
                          height: 280.0,
                          width: 250.0,
                        ),
                      if(plname=="Yerba-Buena")
                        Image(
                          image: AssetImage('assets/images/yerbabuena.jpg'),
                          height: 280.0,
                          width: 250.0,
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
                            Image(image: AssetImage('assets/images/app_logo.png'),height: 280.0,width: 250.0,),
                            SizedBox(height: 15.0),
                            Text('New Medicinal Plant approved by DOH'),
                            Text('Image of this plant soon will be uploaded'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
          dashfname: widget.ftfname,
          dashem: widget.ftemail,
          dashhome: widget.fthome,
          dashcon: widget.ftcon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: 150.0,
          title: Column(
            children: [
              Text("Plant Medic Finder",
                style: TextStyle(
                  fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(widget.ftfname,
                style: TextStyle(
                    fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white
                ),
              ),
              Text(widget.ftemail,
                style: TextStyle(
                    fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.white
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.favorite,size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Favorites",style: TextStyle(fontSize: 20.0),
                  ),
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
                      dashfname: widget.ftfname,
                      dashem: widget.ftemail,
                      dashhome: widget.fthome,
                      dashcon: widget.ftcon,
                    )));
                  },
                  icon: Icon(Icons.home_outlined,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    if(widget.ftemail=="plantmedicfinderadmin@gmail.com"){
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => uploadtab(
                        utfname: widget.ftfname,
                        utemail: widget.ftemail,
                        uthome: widget.fthome,
                        utcon: widget.ftcon,
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
                      atfname: widget.ftfname,
                      atemail: widget.ftemail,
                      athome: widget.fthome,
                      atcon: widget.ftcon,
                    )));
                  },
                  icon: Column(
                    children: [
                      if(widget.ftemail=="plantmedicfinderadmin@gmail.com")
                        Image(
                          image: AssetImage('assets/images/admin.png'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(widget.ftemail=="fdanmerick@gmail.com")
                        Image(
                          image: AssetImage('assets/images/dmf.jpg'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(widget.ftemail!="plantmedicfinderadmin@gmail.com" ||
                          widget.ftemail!="fdanmerick@gmail.com"
                      )Visibility(
                        visible: widget.ftemail=="plantmedicfinderadmin@gmail.com" ||
                            widget.ftemail=="fdanmerick@gmail.com"
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
          future: fetchfavoriteplant(),
          builder: (ctx,ss) {
            if(ss.hasError){
              print("error");
            }
            if(ss.hasData){
              List list = ss.data!;
              return GridView.builder(
                  itemCount: list==null?0:list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (ctx,i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          gotonextactivity(context, list[i]['id']);
                        },
                        child: Card(
                          elevation: 10.0,
                          shadowColor: Colors.lightBlueAccent,
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                if(list[i]['p_name']=="Akapulko")
                                  Image(
                                    image: AssetImage('assets/images/acapulco.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Ampalaya")
                                  Image(
                                    image: AssetImage('assets/images/ampalaya.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Bawang")
                                  Image(
                                    image: AssetImage('assets/images/bawang.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Bayabas")
                                  Image(
                                    image: AssetImage('assets/images/bayabas.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Lagundi")
                                  Image(
                                    image: AssetImage('assets/images/lagundi.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Niyug-Niyogan")
                                  Image(
                                    image: AssetImage('assets/images/niyugniyogan.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Sambong")
                                  Image(
                                    image: AssetImage('assets/images/sambong.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Tsaang Gubat")
                                  Image(
                                    image: AssetImage('assets/images/tsaanggubat.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Ulasimang Bato")
                                  Image(
                                    image: AssetImage('assets/images/ulasimangbato.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']=="Yerba-Buena")
                                  Image(
                                    image: AssetImage('assets/images/yerbabuena.jpg'),
                                    height: 140.0,
                                    width: 140.0,
                                  ),
                                if(list[i]['p_name']!="Akapulko" ||
                                    list[i]['p_name']!="Ampalaya" ||
                                    list[i]['p_name']!="Bawang" ||
                                    list[i]['p_name']!="Bayabas" ||
                                    list[i]['p_name']!="Lagundi" ||
                                    list[i]['p_name']!="Niyug-Niyogan" ||
                                    list[i]['p_name']!="Sambong" ||
                                    list[i]['p_name']!="Tsaang Gubat" ||
                                    list[i]['p_name']!="Ulamisang Bato" ||
                                    list[i]['p_name']!="Yerba-Buena"
                                )Visibility(
                                  visible: list[i]['p_name']=="Akapulko" ||
                                      list[i]['p_name']=="Ampalaya" ||
                                      list[i]['p_name']=="Bawang" ||
                                      list[i]['p_name']=="Bayabas" ||
                                      list[i]['p_name']=="Lagundi" ||
                                      list[i]['p_name']=="Niyug-Niyogan" ||
                                      list[i]['p_name']=="Sambong" ||
                                      list[i]['p_name']=="Tsaang Gubat" ||
                                      list[i]['p_name']=="Ulasimang Bato" ||
                                      list[i]['p_name']=="Yerba-Buena"
                                      ? false
                                      : true ,
                                  child: Column(
                                    children: [
                                      Image(image: AssetImage('assets/images/app_logo.png'),height: 140.0,width: 140.0,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            header: Row(
                              children: [
                                SizedBox(width: 110),
                                IconButton(
                                  color: Colors.red,
                                  icon: Icon(Icons.delete,size: 43),
                                  onPressed: ()=> myAlert(list[i]['id'],list[i]['p_name']),
                                ),
                              ],
                            ),
                            footer: Text(list[i]['p_name'],style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
            else{
              return Center(
                child: Text('No Favorites Yet',style: TextStyle(fontSize: 30,color: Colors.red)),
              );
            }
          },
        ),
      ),
    );
  }
}

class SecondActivity extends StatefulWidget {
  final String idHolder;
  final String sdfname;
  final String sddem;
  final String sddhome;
  final String sddcon;
  SecondActivity(this.idHolder,this.sdfname,this.sddem,this.sddhome,this.sddcon);

  @override
  State<StatefulWidget> createState() {
    return Second(this.idHolder,this.sdfname,this.sddem,this.sddhome,this.sddcon);
  }
}

class Second extends State<SecondActivity> {

  final String idHolder;
  final String dfname;
  final String ddem;
  final String ddhome;
  final String ddcon;

  Second(this.idHolder,this.dfname,this.ddem,this.ddhome,this.ddcon);

  Future<List> fetchplant() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/appgetfavoriteplant.php'); //Api Link
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
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) =>favoritetab(
          ftfname: dfname,
          ftemail: ddem,
          fthome: ddhome,
          ftcon: ddcon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.grass_outlined,size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Selected Plant",style: TextStyle(fontSize: 20.0),
                  ),
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
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0,8.0,25.0,8.0),
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.lightGreen,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite_outline_rounded,size: 35.0),
                                      onPressed: (){
                                        Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) => newfavorite(
                                              nffname: dfname,
                                              nfemail: ddem,
                                              nfhome: ddhome,
                                              nfcon: ddcon,
                                              nfpname:list[i]['p_name'],
                                              nfpdesc:list[i]['p_description'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline,color: Colors.black,size: 35.0),
                                      onPressed: (){
                                        Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) => tagplant(
                                              tgfname: dfname,
                                              tgemail: ddem,
                                              tghome: ddhome,
                                              tgcon: ddcon,
                                              tgpname:list[i]['p_name'],
                                              tgpdesc:list[i]['p_description'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.map,color: Colors.black,size: 35.0),
                                      onPressed: (){
                                        Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) => availablelocations(
                                              alfname: dfname,
                                              alemail: ddem,
                                              alhome: ddhome,
                                              alcon: ddcon,
                                              albyuser: list[i]['user_email'],
                                              alpname: list[i]['p_name'],
                                              alpdesc: list[i]['p_description'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(list[i]['p_name'],style: TextStyle(color: Colors.black,fontSize: 28.0),),
                                    SizedBox(width: 10.0),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Column(
                                  children: <Widget>[
                                    if(list[i]['p_name']=="Akapulko")
                                      Image(
                                        image: AssetImage('assets/images/acapulco.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Ampalaya")
                                      Image(
                                        image: AssetImage('assets/images/ampalaya.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Bawang")
                                      Image(
                                        image: AssetImage('assets/images/bawang.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Bayabas")
                                      Image(
                                        image: AssetImage('assets/images/bayabas.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Lagundi")
                                      Image(
                                        image: AssetImage('assets/images/lagundi.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Niyug-Niyogan")
                                      Image(
                                        image: AssetImage('assets/images/niyugniyogan.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Sambong")
                                      Image(
                                        image: AssetImage('assets/images/sambong.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Tsaang Gubat")
                                      Image(
                                        image: AssetImage('assets/images/tsaanggubat.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Ulasimang Bato")
                                      Image(
                                        image: AssetImage('assets/images/ulasimangbato.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']=="Yerba-Buena")
                                      Image(
                                        image: AssetImage('assets/images/yerbabuena.jpg'),
                                        height: 280.0,
                                        width: 250.0,
                                      ),
                                    if(list[i]['p_name']!="Akapulko" ||
                                        list[i]['p_name']!="Ampalaya" ||
                                        list[i]['p_name']!="Bawang" ||
                                        list[i]['p_name']!="Bayabas" ||
                                        list[i]['p_name']!="Lagundi" ||
                                        list[i]['p_name']!="Niyug-Niyogan" ||
                                        list[i]['p_name']!="Sambong" ||
                                        list[i]['p_name']!="Tsaang Gubat" ||
                                        list[i]['p_name']!="Ulasimang Bato" ||
                                        list[i]['p_name']!="Yerba-Buena"
                                    )Visibility(
                                      visible: list[i]['p_name']=="Akapulko" ||
                                          list[i]['p_name']=="Ampalaya" ||
                                          list[i]['p_name']=="Bawang" ||
                                          list[i]['p_name']=="Bayabas" ||
                                          list[i]['p_name']=="Lagundi" ||
                                          list[i]['p_name']=="Niyug-Niyogan" ||
                                          list[i]['p_name']=="Sambong" ||
                                          list[i]['p_name']=="Tsaang Gubat" ||
                                          list[i]['p_name']=="Ulasimang Bato" ||
                                          list[i]['p_name']=="Yerba-Buena"
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
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(child: Text(list[i]['p_description'],style: TextStyle(color: Colors.black,fontSize: 16.0),textAlign: TextAlign.justify)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

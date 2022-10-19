import 'dart:convert';
import 'dart:core';
import 'package:capstone/AvailableLocations.dart';
import 'package:capstone/ListofAppUsers.dart';
import 'package:capstone/ListofTags.dart';
import 'package:capstone/ListofUploads.dart';
import 'package:capstone/NewFavorite.dart';
import 'package:capstone/Search.dart';
import 'package:capstone/TagPlant.dart';
import 'package:capstone/main.dart';
import 'package:capstone/tabs/AccountTab.dart';
import 'package:capstone/tabs/FavoriteTab.dart';
import 'package:capstone/tabs/UploadTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dashpage extends StatefulWidget {
  final String dashfname;
  final String dashem;
  final String dashhome;
  final String dashcon;
  dashpage({
    required this.dashfname,
    required this.dashem,
    required this.dashhome,
    required this.dashcon,
  });

  _dashpageState createState() => _dashpageState(dfname: dashfname, dem: dashem, dhome: dashhome, dcon: dashcon);
}

class _dashpageState extends State<dashpage> {
  final String dfname;
  final String dem;
  final String dhome;
  final String dcon;
  _dashpageState({required this.dfname,required this.dem,required this.dhome,required this.dcon});


  navigateToNextActivity(BuildContext context, String dataHolder) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SecondScreenState(dataHolder,
            dfname,dem,dhome,dcon)));
  }

  void myAlertmenu(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.lightGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Center(child: Text('Menu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0))),
            content: Container(
              height: 144.0,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
                    onPressed: () {
                      if(dem == "plantmedicfinderadmin@gmail.com"){
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => listofuploads(
                          lufname: dfname,
                          luem: dem,
                          luhome: dhome,
                          lucon: dcon,
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
                                  height: 110.0,
                                  child: Column(
                                    children: [
                                      Text('Sorry, Only Admin can view this.'),
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
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined),
                        SizedBox(width: 15.0),
                        Text('List of Uploads',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
                    onPressed: () {
                      if(dem == "plantmedicfinderadmin@gmail.com"){
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => listofappusers(
                          laufname: dfname,
                          lauem: dem,
                          lauhome: dhome,
                          laucon: dcon,
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
                                  height: 110.0,
                                  child: Column(
                                    children: [
                                      Text('Sorry, Only Admin can view this.'),
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
                    child: Row(
                      children: [
                        Icon(Icons.account_box_outlined),
                        SizedBox(width: 15.0),
                        Text("List of Accounts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => listoftags(
                        ltfname: dfname,
                        ltem: dem,
                        lthome: dhome,
                        ltcon: dcon,
                      )));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.map_outlined),
                        SizedBox(width: 15.0),
                        Text('List of Tags',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ],
                    ),
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

  void getSuggestion() async{  //get suggestion function
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

  Future<bool> _onwillpop() async {
    return (await showDialog(
      context: context,
      builder: (BuildContext context)=>AlertDialog(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Center(child: Text('Are you sure?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0))),
        content: Text('Do you want to Log Out',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
            onPressed: ()=>Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
            onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>loginpage())),
            child: Text('Yes'),
          ),
        ],
      ),
    ))??false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillpop,
      child: Scaffold(
        backgroundColor: Colors.green.shade900,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu,size: 30.0),
                    onPressed: (){
                      myAlertmenu();
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text("Medicinal Plants",style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/plant.png'),
                    height: 38.0,
                    width: 38.0,
                  ),
                  Container(
                    width: 100.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SearchBar(
                                  sedfname: dfname,
                                  sedem: dem,
                                  sedhome: dhome,
                                  sedcon: dcon,
                                )
                            )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text('Search'),
                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/images/plant.png'),
                    height: 38.0,
                    width: 38.0,
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
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => favoritetab(
                      ftfname: dfname,
                      ftemail: dem,
                      fthome: dhome,
                      ftcon: dcon,
                    )));
                  },
                  icon: Icon(Icons.favorite,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    if(dem == "plantmedicfinderadmin@gmail.com"){
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => uploadtab(
                        utfname: dfname,
                        utemail: dem,
                        uthome: dhome,
                        utcon: dcon,
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
                      atemail: dem,
                      athome: dhome,
                      atcon: dcon,
                    )));
                  },
                  icon: Column(
                    children: [
                      if(dem=="plantmedicfinderadmin@gmail.com")
                        Image(
                          image: AssetImage('assets/images/admin.png'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(dem=="fdanmerick@gmail.com")
                        Image(
                          image: AssetImage('assets/images/dmf.jpg'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(dem!="plantmedicfinderadmin@gmail.com" ||
                          dem!="fdanmerick@gmail.com"
                      )Visibility(
                        visible: dem=="plantmedicfinderadmin@gmail.com" ||
                            dem=="fdanmerick@gmail.com"
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
            padding: const EdgeInsets.only(left: 8.0,top: 13.0,right: 8.0),
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.lightBlueAccent,
              color: Colors.green,
              child: ListTile(
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                tileColor: Colors.green,
                onTap: (){
                  print(suggestion.id);
                  navigateToNextActivity(context, suggestion.id);
                },
                title: Text(suggestion.pname, style: TextStyle(fontSize:24, fontWeight:FontWeight.normal),),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if(suggestion.pname=="Akapulko")
                      Image(
                        image: AssetImage('assets/images/acapulco.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Ampalaya")
                      Image(
                        image: AssetImage('assets/images/ampalaya.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Bawang")
                      Image(
                        image: AssetImage('assets/images/bawang.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Bayabas")
                      Image(
                        image: AssetImage('assets/images/bayabas.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Lagundi")
                      Image(
                        image: AssetImage('assets/images/lagundi.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Niyug-Niyogan")
                      Image(
                        image: AssetImage('assets/images/niyugniyogan.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Sambong")
                      Image(
                        image: AssetImage('assets/images/sambong.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Tsaang Gubat")
                      Image(
                        image: AssetImage('assets/images/tsaanggubat.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Ulasimang Bato")
                      Image(
                        image: AssetImage('assets/images/ulasimangbato.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname=="Yerba-Buena")
                      Image(
                        image: AssetImage('assets/images/yerbabuena.jpg'),
                        height: 38.0,
                        width: 38.0,
                      ),
                    if(suggestion.pname!="Akapulko" ||
                        suggestion.pname!="Ampalaya" ||
                        suggestion.pname!="Bawang" ||
                        suggestion.pname!="Bayabas" ||
                        suggestion.pname!="Lagundi" ||
                        suggestion.pname!="Niyug-Niyogan" ||
                        suggestion.pname!="Sambong" ||
                        suggestion.pname!="Tsaang Gubat" ||
                        suggestion.pname!="Ulamisang Bato" ||
                        suggestion.pname!="Yerba-Buena"
                    )Visibility(
                      visible: suggestion.pname=="Akapulko" ||
                          suggestion.pname=="Ampalaya" ||
                          suggestion.pname=="Bawang" ||
                          suggestion.pname=="Bayabas" ||
                          suggestion.pname=="Lagundi" ||
                          suggestion.pname=="Niyug-Niyogan" ||
                          suggestion.pname=="Sambong" ||
                          suggestion.pname=="Tsaang Gubat" ||
                          suggestion.pname=="Ulasimang Bato" ||
                          suggestion.pname=="Yerba-Buena"
                          ? false
                          : true ,
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/images/app_logo.png'),height: 38.0,width: 38.0,),
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SecondScreenState extends StatefulWidget {
  final String idHolder;
  final String sdfname;
  final String sddem;
  final String sddhome;
  final String sddcon;
  SecondScreenState(this.idHolder,this.sdfname,this.sddem,this.sddhome,this.sddcon);

  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder,this.sdfname,this.sddem,this.sddhome,this.sddcon);
  }
}

class SecondScreen extends State<SecondScreenState> {
  final String idHolder;
  final String dfname;
  final String ddem;
  final String ddhome;
  final String ddcon;

  SecondScreen(this.idHolder,this.dfname,this.ddem,this.ddhome,this.ddcon);

  Future<List> fetchplant() async{
    var url = Uri.parse('http://plantmedicfinder.rf.gd/system/getplant.php'); //Api Link
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
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: dfname,
          dashem: ddem,
          dashhome: ddhome,
          dashcon: ddcon,
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
                  Icon(Icons.grass_rounded,size: 30.0),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                              alpname:list[i]['p_name'],
                                              alpdesc:list[i]['p_description'],
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
import 'dart:io';

import 'package:capstone/DashPage.dart';
import 'package:capstone/Uploaded.dart';
import 'package:capstone/tabs/AccountTab.dart';
import 'package:capstone/tabs/FavoriteTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class uploadtab extends StatefulWidget {
  final String utfname;
  final String utemail;
  final String uthome;
  final String utcon;
  uploadtab({
    required this.utfname,
    required this.utemail,
    required this.uthome,
    required this.utcon,
  });

  @override
  State<uploadtab> createState() => _uploadtabState();
}

class _uploadtabState extends State<uploadtab> {

  TextEditingController plantcname = TextEditingController();
  TextEditingController plantdesc = TextEditingController();

  late TextEditingController home;
  late TextEditingController useremail;
  Color? w = Colors.white;

  @override
  void initState() {
    home = TextEditingController(text: widget.uthome);
    useremail = TextEditingController(text: widget.utemail);
    super.initState();
  }

  Future uploadplant()async{
    if(plantcname.text==""||home.text==""||plantdesc.text==""){
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Please fill all fields',
        toastLength: Toast.LENGTH_SHORT,
      );
    }else{
      try{
        final uri = Uri.parse("http://plantmedicfinder.rf.gd/system/plantuploadapp.php");
        var request = http.MultipartRequest('POST',uri);
        request.fields['plantname'] = plantcname.text;
        request.fields['planthomeadd'] = home.text;
        request.fields['plantdescription'] = plantdesc.text;
        request.fields['useremail'] = useremail.text;
        var response = await request.send();
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            backgroundColor: Colors.green.shade900,
            textColor: Colors.white,
            msg: 'Uploading Successful',
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => uploaded(
                ufname: widget.utfname,
                uem: widget.utemail,
                uhome: widget.uthome,
                ucon: widget.utcon,
                uplantcname: plantcname.text,
                uplantloc: home.text,
                uplantdesc: plantdesc.text,
              ),
            ),
          );
        }else{
          Fluttertoast.showToast(
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            msg: 'Unsuccessful Upload',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        setState(() {});
      }catch(e){
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: widget.utfname,
          dashem: widget.utemail,
          dashhome: widget.uthome,
          dashcon: widget.utcon,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.upload_outlined,size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Upload Medicinal Plant",style: TextStyle(fontSize: 20.0),
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
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) =>dashpage(
                      dashfname: widget.utfname,
                      dashem: widget.utemail,
                      dashhome: widget.uthome,
                      dashcon: widget.utcon,
                    )));
                  },
                  icon: Icon(Icons.home_outlined,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) =>favoritetab(
                      ftfname: widget.utfname,
                      ftemail: widget.utemail,
                      fthome: widget.uthome,
                      ftcon: widget.utcon,
                    )));
                  },
                  icon: Icon(Icons.favorite,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => accounttab(
                      atfname: widget.utfname,
                      atemail: widget.utemail,
                      athome: widget.uthome,
                      atcon: widget.utcon,
                    )));
                  },
                  icon: Column(
                    children: [
                      if(widget.utemail=="plantmedicfinderadmin@gmail.com")
                        Image(
                          image: AssetImage('assets/images/admin.png'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(widget.utemail=="fdanmerick@gmail.com")
                        Image(
                          image: AssetImage('assets/images/dmf.jpg'),
                          height: 32.0,
                          width: 32.0,
                        ),
                      if(widget.utemail!="plantmedicfinderadmin@gmail.com" ||
                          widget.utemail!="fdanmerick@gmail.com"
                      )Visibility(
                        visible: widget.utemail=="plantmedicfinderadmin@gmail.com" ||
                            widget.utemail=="fdanmerick@gmail.com"
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*
                    Container(
                      child: IconButton(
                        iconSize: 70.0,
                        onPressed: (){},
                        icon: Image.network("http://plantmedicfinder.rf.gd/system/image/${widget.utprofile}"),
                      ),
                    ),
                     */
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.utfname,
                            style: TextStyle(
                                fontSize: 25,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                          Text(widget.utemail,
                            style: TextStyle(
                              fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.white,
                            ),textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,8.0,20.0,8.0),
                  child: Column(
                    children: [
                      Text('UPLOAD PLANT',style: TextStyle(fontSize: 25.0,color: w),),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          ImageIcon(AssetImage('assets/images/plant.png'),color: w,size: 33.0,),
                          SizedBox(width: 10.0),
                          Text('Plant Details',style: TextStyle(fontSize: 22.0, color: w),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Common Name:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: plantcname,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: "Plant's Name",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 50,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("User's Home Address:",style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: home,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: "Plant's Location",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 50,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: plantdesc,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: "Short Descriptions",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 50,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 10),
                      Visibility(
                        visible: false,
                        child: TextField(controller: useremail),
                      ),
                      SizedBox(height: 10.0),
                      /*
                      Container(
                        height: 50.0,
                        width: 75.0,
                        child: _image == null ? Center(child: Text('No Image Selected')) : Image.file(_image!),
                      ),
                       */
                      SizedBox(height: 10.0),
                      RaisedButton(
                        onPressed: (){
                          if(plantcname.text==""||home.text==""||plantdesc.text==""){
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              msg: 'Please fill all fields',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }else{
                            uploadplant();
                          }
                        },
                        color: Colors.green.shade900,
                        child: Text("Upload",style: TextStyle(fontSize: 20.0, color: w),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
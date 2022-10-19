import 'package:capstone/DashPage.dart';
import 'package:capstone/tabs/FavoriteTab.dart';
import 'package:capstone/tabs/UploadTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';

class accounttab extends StatefulWidget {
  final String atfname;
  final String atemail;
  final String athome;
  final String atcon;
  accounttab({required this.atfname, required this.atemail, required this.athome, required this.atcon});

  @override
  State<accounttab> createState() => _accounttabState();
}

class _accounttabState extends State<accounttab> {

  Color? w = Colors.white;
  final _formKey = GlobalKey<FormState>();

  Future updateactiveaccount() async {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      msg: 'Unsuccessful Updating',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void myalert(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.lightGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Center(child: Text('Update your Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0))),
            content: Container(
              height: 328.0,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Full Name';
                            }
                            return null;
                          },
                          //controller: fname,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Full Name',
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
                        TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Phone Number';
                            }
                            return null;
                          },
                          //controller:pnumber,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
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
                        TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Home Address';
                            }
                            return null;
                          },
                          //controller: home,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Home Address',
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
                        TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                          //controller: email,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Email',
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
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange, // Background color
                            ),
                            onPressed: ()=>{
                              if(_formKey.currentState!.validate()){
                                updateactiveaccount()
                              }
                            },
                            child: Text('Update'),
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
          dashfname: widget.atfname,
          dashem: widget.atemail,
          dashhome: widget.athome,
          dashcon: widget.atcon,
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
                  Icon(Icons.person_outline_sharp,size: 30.0),
                  SizedBox(width: 10.0),
                  Text("User's Account",style: TextStyle(fontSize: 20.0),
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
                      dashfname: widget.atfname,
                      dashem: widget.atemail,
                      dashhome: widget.athome,
                      dashcon: widget.atcon,
                    )));
                  },
                  icon: Icon(Icons.home_outlined,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => favoritetab(
                      ftfname: widget.atfname,
                      ftemail: widget.atemail,
                      fthome: widget.athome,
                      ftcon: widget.atcon,
                    )));
                  },
                  icon: Icon(Icons.favorite,size:35.0),
                ),
                IconButton(
                  onPressed: (){
                    if(widget.atemail=="plantmedicfinderadmin@gmail.com"){
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => uploadtab(
                        utfname: widget.atfname,
                        utemail: widget.atemail,
                        uthome: widget.athome,
                        utcon: widget.atcon,
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
                        icon: Image.network("http://plantmedicfinder.rf.gd/system/image/${widget.atprofile}"),
                      ),
                    ),
                     */
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.atfname,
                            style: TextStyle(
                                fontSize: 25,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: w
                            ),
                          ),
                          Text(widget.atemail,
                            style: TextStyle(
                                fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: w
                            ),textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: w,
                  ),
                  height: 30.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,8.0,20.0,8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('ACCOUNT',style: TextStyle(fontSize: 25.0,color: w),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 56.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Background color
                              ),
                              onPressed: (){
                                myalert();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined,color: w,size: 33.0,),
                          SizedBox(width: 10.0),
                          Text('Personal Information',style: TextStyle(fontSize: 22.0, color: w),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Name:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 45.0),
                          Icon(Icons.person,color: w,size: 20.0,),
                          SizedBox(width: 10.0),
                          Text(widget.atfname,style: TextStyle(fontSize: 20.0, color: w),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Phone number:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 45.0),
                          Icon(Icons.phone,color: w,size: 20.0,),
                          SizedBox(width: 10.0),
                          Text(widget.atcon,style: TextStyle(fontSize: 20.0, color: w),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Home Address:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 45.0),
                          Icon(Icons.home_outlined,color: w,size: 20.0,),
                          SizedBox(width: 10.0),
                          Expanded(child: Text(widget.athome,style: TextStyle(fontSize: 20.0, color: w),)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Email:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 45.0),
                          Icon(Icons.email,color: w,size: 20.0,),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(widget.atemail,style: TextStyle(fontSize: 20.0, color: w),textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        child: Text("Log Out", style: TextStyle(color: Colors.white, fontSize: 25),),
                        padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                        color: Colors.red,
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>loginpage()));
                        },
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
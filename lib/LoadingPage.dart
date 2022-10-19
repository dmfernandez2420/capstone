import 'package:capstone/DashPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatefulWidget {
  final String fname;
  final String em;
  final String home;
  final String con;
  loading({
    required this.fname,
    required this.em,
    required this.home,
    required this.con});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => dashpage(
        dashfname: widget.fname,
        dashem: widget.em,
        dashhome: widget.home,
        dashcon: widget.con,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/capspic.png'),
                width: 250.0,
              ),
              Text("Profile",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.greenAccent),),
              SizedBox(height: 20.0),
              Text("Complete",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.greenAccent),),
              SizedBox(height: 30.0),
              SpinKitCircle(color:Colors.white,size:60.0,),
              SizedBox(height: 20.0),
              Column(
                children: [
                  if(widget.em=="plantmedicfinderadmin@gmail.com")
                    Image(
                      image: AssetImage('assets/images/admin.png'),
                      height: 130.0,
                      width: 130.0,
                    ),
                  if(widget.em=="fdanmerick@gmail.com")
                    Image(
                      image: AssetImage('assets/images/dmf.jpg'),
                      height: 130.0,
                      width: 130.0,
                    ),
                  if(widget.em!="plantmedicfinderadmin@gmail.com" ||
                      widget.em!="fdanmerick@gmail.com"
                  )Visibility(
                    visible: widget.em=="plantmedicfinderadmin@gmail.com" ||
                        widget.em=="fdanmerick@gmail.com"
                        ? false
                        : true ,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/user.png'),
                          height: 130.0,
                          width: 130.0,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text('Welcome "${widget.fname}"',style: TextStyle(fontSize: 20)),
              SizedBox(height: 10.0),
              Text('Thank you for choosing "Plant Medic Finder App"'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:capstone/tabs/UploadTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DashPage.dart';


class uploaded extends StatefulWidget {
  final String ufname;
  final String uem;
  final String uhome;
  final String ucon;
  final String uplantcname;
  final String uplantloc;
  final String uplantdesc;

  uploaded({
    required this.ufname,
    required this.uem,
    required this.uhome,
    required this.ucon,
    required this.uplantcname,
    required this.uplantloc,
    required this.uplantdesc,
  });

  @override
  State<uploaded> createState() => _uploadedState();
}

class _uploadedState extends State<uploaded> {
  Color? w = Colors.white;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => uploadtab(
          utfname: widget.ufname,
          utemail: widget.uem,
          uthome: widget.uhome,
          utcon: widget.ucon,
        )));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/capspic.png'),
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.ufname,
                            style: TextStyle(
                                fontSize: 25,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                          Text(widget.uem,
                            style: TextStyle(
                                fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.white
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
                      Text('UPLOADED PLANT',style: TextStyle(fontSize: 25.0,color: w),),
                      SizedBox(height: 20),
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
                      Row(
                        children: [
                          SizedBox(width: 20.0),
                          Text(widget.uplantcname,style: TextStyle(fontSize: 20.0, color: w),textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Location:',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Text(widget.uhome,style: TextStyle(fontSize: 20.0, color: w),textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Description',style: TextStyle(fontSize: 20.0, color: w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Text(widget.uplantdesc,style: TextStyle(fontSize: 20.0, color: w),textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      /*
                      Container(
                        height: 200.0,
                        width: 300.0,
                        child: Image.file(widget.uplantimage!),
                      ),
                       */
                      RaisedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>dashpage(
                            dashfname: widget.ufname,
                            dashem: widget.uem,
                            dashhome: widget.uhome,
                            dashcon: widget.ucon,
                          )));
                        },
                        color: Colors.green.shade900,
                        child: Text("Ok",style: TextStyle(fontSize: 20.0, color: w),
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
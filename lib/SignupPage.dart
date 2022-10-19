import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {

  TextEditingController namecontrol = TextEditingController();
  TextEditingController contactcontrol = TextEditingController();
  TextEditingController homecontrol = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();


  Future signup()async{
    if(namecontrol.text==""||contactcontrol.text==""||homecontrol.text==""||emailcontrol.text==""||passcontrol.text==""){
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Please fill all fields',
        toastLength: Toast.LENGTH_SHORT,
      );
    }else{
      try{
        final uri = Uri.parse("http://plantmedicfinder.rf.gd/system/appregister.php");
        var request = http.MultipartRequest('POST',uri);
        request.fields['fullname'] = namecontrol.text;
        request.fields['contact'] = contactcontrol.text;
        request.fields['homeaddress'] = homecontrol.text;
        request.fields['emailaddress'] = emailcontrol.text;
        request.fields['password'] = passcontrol.text;
        var response = await request.send();
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            backgroundColor: Colors.green.shade900,
            textColor: Colors.white,
            msg: 'Registration Successful',
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => loginpage(),
            ),
          );
        }else{
          Fluttertoast.showToast(
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            msg: 'Unsuccessful register',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        setState(() {});
      }catch(e){
        print(e);
      }
    }
  }

  Future<bool> _onwillpop() async {
    return (await showDialog(
      context: context,
      builder: (BuildContext context)=>AlertDialog(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Center(child: Text('Are you sure?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0))),
        content: Text('Do you want to exit this App',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
            onPressed: ()=>Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
            onPressed: ()=>SystemNavigator.pop(),
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
        backgroundColor: Colors.green,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage('assets/images/capspic.png'),
                          height: 80.0,
                          width: 80.0,
                        ),
                      ),
                      Text("Plant Medic Finder",
                        style: TextStyle(
                          fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: Text("Sign In",
                          style: TextStyle(color: Colors.green,fontSize: 25),
                        ),
                        color:Colors.white,
                        onPressed:(){},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: Text("Sign Up",
                          style: TextStyle(color: Colors.white,fontSize: 25),
                        ),
                        color:Colors.green.shade900,
                        onPressed:(){},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 330,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: namecontrol,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Enter your Name',
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
                            SizedBox(height: 5),
                            TextField(
                              controller: contactcontrol,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Contact Number',
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
                            SizedBox(height: 5),
                            TextField(
                              controller: homecontrol,
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
                            SizedBox(height: 5),
                            TextField(
                              controller: emailcontrol,
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
                            SizedBox(height: 5),
                            TextField(
                              controller: passcontrol,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Password',
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
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*
                      Container(
                        height: 50.0,
                        width: 75.0,
                        child: _image == null ? Center(child: Text('No Image Selected')) : Image.file(_image!),
                      ),
                       */
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 25),),
                        padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                        color: Colors.green.shade900,
                        onPressed: (){
                          if(namecontrol.text==""||contactcontrol.text==""||homecontrol.text==""||emailcontrol.text==""||passcontrol.text==""){
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              msg: 'Please fill all fields',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }else{
                            signup();
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: TextStyle(fontSize: 18,),),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>loginpage(),)),
                            child: const Text("LOG In",
                              style: TextStyle(fontSize: 24,decoration: TextDecoration.underline, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

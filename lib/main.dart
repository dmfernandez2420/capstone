import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:capstone/LoadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'DashPage.dart';
import 'SignupPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Medic Finder',
      home: splashscreen(),
    );
  }
}
class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => loginpage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/capspic.png'),
              width: 300.0,
            ),
            //SpinKitSquareCircle(color:Colors.red,size:50.0,),
          ],
        ),
      ),
    );
  }
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  bool _visible = false;

  TextEditingController emailadd = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    try{
      String url = "http://plantmedicfinder.rf.gd/system/signapp.php";
      setState((){
        _visible = true;
      });
      var data = {
        'email':emailadd.text,
        'pas':pass.text,
      };
      var response = await http.post(Uri.parse(url),body:json.encode(data));
      if(response.statusCode == 200) {
        print(response.body);
        var msg = jsonDecode(response.body);
        if(msg['loginStatus']==true){
          setState(() {
            _visible = false;
          });
          Fluttertoast.showToast(
            backgroundColor: Colors.green.shade900,
            textColor: Colors.white,
            msg: 'Login Successful',
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => loading(
                  fname: msg['userInfo']['full_name'],
                  em: msg['userInfo']['email_address'],
                  home: msg['userInfo']['home_address'],
                  con: msg['userInfo']['contact_number']
              ),
            ),
          );
        } else {
          setState(() {
            _visible = false;
            Fluttertoast.showToast(
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              msg: 'Email and Password Invalid',
              toastLength: Toast.LENGTH_SHORT,
            );
          });
        }
      } else {
        setState(() {
          _visible = false;
          AlertDialog(
            title: Text("Error during connecting to Server."),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      }
    }catch(e){
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

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
                          style: TextStyle(color: Colors.white,fontSize: 25),
                        ),
                        color:Colors.green.shade900,
                        onPressed:(){},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: Text("Sign Up",
                          style: TextStyle(color: Colors.green,fontSize: 25),
                        ),
                        color:Colors.white,
                        onPressed:(){},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                controller: emailadd,
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
                              TextFormField(
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                controller: pass,
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
                        RaisedButton(
                          child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: 25),),
                          padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                          color: Colors.green.shade900,
                          onPressed: ()=>{
                            if(_formKey.currentState!.validate()){
                              login()
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?", style: TextStyle(fontSize: 18,),),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>signuppage(),)),
                              child: const Text("Sign Up",
                                style: TextStyle(fontSize: 24,decoration: TextDecoration.underline, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

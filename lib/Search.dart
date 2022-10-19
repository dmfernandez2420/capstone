import 'dart:convert';

import 'package:capstone/DashPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatefulWidget{

  final String sedfname;
  final String sedem;
  final String sedhome;
  final String sedcon;
  SearchBar({
    required this.sedfname,
    required this.sedem,
    required this.sedhome,
    required this.sedcon,});
  @override
  State createState() {
    return _SearchBar(dfname: sedfname, dem: sedem, dhome: sedhome, dcon: sedcon);
  }
}

class _SearchBar extends State{
  final String dfname;
  final String dem;
  final String dhome;
  final String dcon;
  _SearchBar({
    required this.dfname,
    required this.dem,
    required this.dhome,
    required this.dcon,
  });

  late bool searching;
  late bool error;
  late String query;
  var data;
  String dataurl = "http://plantmedicfinder.rf.gd/system/search_suggestion.php";

  @override
  void initState() {
    searching = true;
    error = false;
    query = "";
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed:(){
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) =>dashpage(
                dashfname: dfname,
                dashem: dem,
                dashhome: dhome,
                dashcon: dcon,
              )));
            }
        ),
        title:searchField(),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed:(){
                setState(() {
                  searching = true;
                });
              }
          ),
        ],
      ),
      body:Center(
        child: SingleChildScrollView(
          child:Container(
            alignment: Alignment.center,
            child:data == null
                ? Container(
                padding: EdgeInsets.all(20),
                child: Text("No Result",style: TextStyle(fontSize: 28),)
            )
                : Container(
              child: searching
                  ?showSearchSuggestions()
                  :Text("Must Click the Search Icon first"),
            ),
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
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              tileColor: Colors.green,
              onTap: (){
                print(suggestion.id);
                nextactivity(context, suggestion.id);
              },
              title: Text(suggestion.pname, style: TextStyle(fontSize:20, fontWeight:FontWeight.bold,),),
              leading: Image(
                image: AssetImage('assets/images/plant.png'),
                height: 38.0,
                width: 38.0,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  nextactivity(BuildContext context, String dataHolder) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SecondScreenState(dataHolder,dfname,dem,dhome,dcon)));
  }

  Widget searchField(){ //search input field
    return Container(
        child:TextField(
          autofocus: true,
          style: TextStyle(color:Colors.white, fontSize: 18),
          decoration:const InputDecoration(
            hintStyle: TextStyle(color:Colors.white, fontSize: 18),
            hintText: "Search Plant",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.white, width:2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.white, width:2),
            ),
          ),

          onChanged: (value){
            query = value; //update the value of query
            getSuggestion(); //start to get suggestion
          },
        ),
    );
  }
}


//serarch suggestion data model to serialize JSON data
class SearchSuggestion{
  String id, pname;
  SearchSuggestion({required this.id,required this.pname});

  factory SearchSuggestion.fromJSON(Map<String, dynamic> json){
    return SearchSuggestion(
      id: json["id"],
      pname: json["pname"],
    );
  }
}
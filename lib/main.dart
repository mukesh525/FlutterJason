import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

import 'model/User.dart';

void main() async {
 List<User> _data= await fetchPost();
  runApp(new MaterialApp(
    title: "Layouts",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
        body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext contex,int positon){
                if(positon.isOdd) return new Divider();
                final index =positon ~/2; // we are dividing position by 2 and returning integer result
                return new ListTile(
                  title: new Text("${_data[index].title}",
                      style: new TextStyle(fontSize: 13.9)),
                  subtitle: new Text("${_data[index].body}",style: new TextStyle(fontSize: 13.4,color: Colors.grey,fontStyle: FontStyle.italic),),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.green,
                    child: new Text("${_data[index].body[0].toString().toUpperCase()}",style: new TextStyle(fontSize: 15.4,color: Colors.white),)
                  ),
                  onTap: ()=>{showOnTapMessage(contex,"${_data[index].title}")},
                );
              }
          ),
        )

  )));

}


void showOnTapMessage(BuildContext context,String message){
  var alert = new AlertDialog(
    title: new Text("Title"),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text("ok"))
    ],
  );
  showDialog(context: context,child: alert);

}





Future<List<User>> fetchPost()async{
  String url="https://jsonplaceholder.typicode.com/posts";
  http.Response response= await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    List<User> users = (parsedJson as List).map((dynamic model)=> User.fromJson(model)).toList();
    return users;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

}

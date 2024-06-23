import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Practice1 extends StatefulWidget {
  const Practice1({super.key});

  @override
  State<Practice1> createState() => _Practice1State();
}

class _Practice1State extends State<Practice1> {
  Future<bool>? _comment;
  final ctlName = TextEditingController();
  final ctlDes = TextEditingController();

  Future<bool> addValue(String catName, String Desp) async{
    var res =await http.post(
      Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"
      ),
      headers: <String,String>{
        'Content-Type':'application/json; charset=utf-8'
      },
      body: jsonEncode(<String,dynamic>{
        "categoryId" : 0,
        "category" : catName,
        "description": Desp,
        "createdBy": 1

    }));
    return jsonDecode(res.body)["success"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _comment==null
      ?Center(
        child: Column(
          children: [
            TextFormField(
              controller: ctlName,
            ),
            TextFormField(
              controller: ctlDes,
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _comment = addValue(ctlName.text, ctlDes.text);
                  });
                },
                child: Text('Update'))
          ],
        ),
      )
      :FutureBuilder(
          future: _comment,
          builder: (BuildContext context,snapshot){
            if(snapshot.hasData){
              return Text('Save Success');
            }else if(snapshot.hasError){
              return Text('Error Occur');
            }
            return Center(child: RefreshProgressIndicator(
              color: Colors.green,
              backgroundColor: Colors.red,
              elevation: 1,
            ));
          })
    );
  }
}

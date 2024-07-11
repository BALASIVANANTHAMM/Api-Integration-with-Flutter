import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserApi extends StatefulWidget {
  const AddUserApi({super.key});

  @override
  State<AddUserApi> createState() => _AddUserApiState();
}

class _AddUserApiState extends State<AddUserApi> {
  final nameCtl =TextEditingController();
  final emailCtl =TextEditingController();
  final passCtl =TextEditingController();
  final addressCtl =TextEditingController();
  String result = '';

  Future<void> _fetch() async{
    try{
      var response = await http.post(
          Uri.parse("https://fakestoreapi.com/users"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String,dynamic>{
            'email':emailCtl.text,
            'username':nameCtl.text,
            'password':passCtl.text,
            'address':addressCtl.text
          })
      );
      if(response.statusCode==200){
        var resData=jsonDecode(response.body);
        setState(() {
          result='success';
          //result="Name : ${resData['username']}\nEmail : ${resData['email']}\nAddress : ${resData['address']}\nPassword : -------";
        });
      }else{
        throw Exception('Failed to Add User');
      }
    }
    catch(e){
      setState(() {
        result='Error : $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name'
              ),
              controller: nameCtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email'
              ),
              controller: emailCtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address'
              ),
              controller: addressCtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password'
              ),
              controller: passCtl,
            ),
          ),
          ElevatedButton(onPressed: _fetch, child: Text('Submit')),
          Text(result)
        ],
      ),
    );
  }
}

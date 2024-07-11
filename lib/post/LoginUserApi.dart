import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthUserApi extends StatefulWidget {
  const AuthUserApi({super.key});

  @override
  State<AuthUserApi> createState() => _AuthUserApiState();
}

class _AuthUserApiState extends State<AuthUserApi> {
  String result='';
  final nameCtl=TextEditingController();
  final passCtl=TextEditingController();

  Future<void> fetch() async{
   try{
     var res=await http.post(
       Uri.parse('https://fakestoreapi.com/auth/login'),
       // headers: <String,String>{
       //   'text/html': 'charset=utf-8'
       // },
       body: (<String,dynamic>{
         'username': nameCtl.text,
         'password': passCtl.text
       }),
     );
     if(res.statusCode==200){
       var data = jsonDecode(res.body);
       setState(() {
         result='Name : ${data['username']}\nPassword : ${data['password']}';
         // result='success';
       });
     }else{
       throw Exception('Failed to Add User');
     }
   }catch(e){
     setState(() {
       result = 'Error : $e';
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passCtl,
                decoration: const InputDecoration(
                    hintText: 'User Name',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: fetch, child: const Text('Check')),
            SizedBox(height: 10,),
            Text(result)
          ],
        ),
      ),
    );
  }
}

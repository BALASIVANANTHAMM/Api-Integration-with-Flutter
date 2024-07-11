import 'dart:convert';

import 'package:flutter/material.dart';

import '../Api/DbData.dart';
import 'package:http/http.dart' as http;

class Db1 extends StatefulWidget {
  const Db1({super.key});

  @override
  State<Db1> createState() => _Db1State();
}

class _Db1State extends State<Db1> {


  Future<List<DbData>> fetch() async{
    var res=await http.get(Uri.parse('https://balasivananthamm.github.io/host_api/sample.json'));
    var data = await jsonDecode(res.body);
    return (data as List).map((d)=>DbData.fromJson(d)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<DbData> l = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (BuildContext context, int index){
                return Card(
                  child: Column(
                    children: [
                      Text(l[index].id.toString()),
                      Text(l[index].street.toString()),
                      Text(l[index].city.toString()),
                      Text(l[index].state.toString()),
                    ],
                  ),
                );
              }),
            );
          }else if(snapshot.hasError){
            return const Center(child: Text('Loading...'));
          }
          return const Center(child: CircularProgressIndicator());
        },),
    );
  }
}

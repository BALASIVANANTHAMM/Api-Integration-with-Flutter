import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api/RandomUser.dart';

class RandomApi extends StatefulWidget {
  const RandomApi({super.key});

  @override
  State<RandomApi> createState() => _RandomApiState();
}

class _RandomApiState extends State<RandomApi> {
  Future<RandomUser> fetch() async{
    var res = await http.get(Uri.parse("https://randomuser.me/api/"));
    return RandomUser.fromJson(jsonDecode(res.body));
  }
  // Future<List<Results>> futur()async{
  //   var result = await http.get(Uri.parse("https://randomuser.me/api/"));
  //   var data = jsonDecode(result.body);
  //   return (data as List).map((v)=>Results.fromJson(v)).toList();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, snapshot) {
          List<Results>? l = snapshot.data!.results;
          if(snapshot.hasData){
            print('${l!.length} This is List Length');
            return Expanded(
              child: ListView.builder(
                itemCount: l.length,
                  itemBuilder: (BuildContext context, int index){
                    return Text(l[index].name!.first.toString());
                  }),
            );
          }else if(snapshot.hasError){
            Text('Error Occur');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },),
    );
  }
}

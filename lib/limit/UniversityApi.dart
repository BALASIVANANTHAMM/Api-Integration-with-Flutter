import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api/UniversityModel.dart';

class UniversityApi extends StatefulWidget {
  const UniversityApi({super.key});

  @override
  State<UniversityApi> createState() => _UniversityApiState();
}

class _UniversityApiState extends State<UniversityApi> {
  Future<List<University>> fetch() async{
    var res = await http
        .get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    var data = jsonDecode(res.body);
    return (data as List).map((value)=>University.fromJson(value)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            List<University>? list = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: list!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(list[index].alphaTwoCode.toString()),
                    title: Column(
                      children: [
                        Text(list[index].name.toString()),
                        //Text(list[index].webPages![index]),
                      ],
                    ),
                  );
                },
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: Text('Error Occur'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },),
    );
  }
}

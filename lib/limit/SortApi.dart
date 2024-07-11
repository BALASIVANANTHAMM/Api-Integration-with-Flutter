import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api/SortApiModel.dart';

class SortApiUi extends StatefulWidget {
  const SortApiUi({super.key});

  @override
  State<SortApiUi> createState() => _SortApiUiState();
}

class _SortApiUiState extends State<SortApiUi> {
  bool hasD=false;
  bool d=false;
  String a ='asc';

  Future<List<SortApi>> fetch() async{
    var res = await http.get(Uri.parse('https://fakestoreapi.com/users?sort=$a'));
    var data = jsonDecode(res.body);
    return (data as List).map((e)=>SortApi.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasD==false
      ?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                a='asc';
                hasD=true;
              });
            }, child: const Text('Ascending')),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              setState(() {
              a='desc';
              hasD=true;

              });
            }, child: const Text('Descending')),
          ],
        ),
      )
      :FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<SortApi> l = snapshot.data;
          if(snapshot.hasData){
            return Column(
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    hasD=false;
                  });
                }, child: Text('Sort')),
                Expanded(
                  child: ListView.builder(
                    itemCount: l.length,
                      itemBuilder: (BuildContext context, int i){
                        return ListTile(
                          leading: Text(l[i].id.toString()),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l[i].username!),
                              Text(l[i].email!)
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
          }else if(l.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Text('Error : ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },)
    );
  }
}

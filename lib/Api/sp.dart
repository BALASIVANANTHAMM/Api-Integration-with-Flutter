import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modalSp.dart';

class Sp extends StatefulWidget {
  const Sp({super.key});

  @override
  State<Sp> createState() => _SpState();
}

class _SpState extends State<Sp> {

  Future<List<ModalSp>> fetch() async{
      var res = await http.get(Uri.parse('https://localhost:7295/SpGet'));
      var data = await jsonDecode(res.body);
      return (data as List).map((e)=>ModalSp.fromJson(e)).toList();
  }
  final ctlId = TextEditingController();
  final ctlPlace = TextEditingController();
  final ctlRole = TextEditingController();
  final ctlSalery = TextEditingController();
  Future<bool>? comment;
  Future<bool> addValue(int id,String place, String role,int sal) async{
    var res =await http.post(
        Uri.parse("https://localhost:7295/SpInsert"
        ),
        headers: <String,String>{
          'content-type':'application/json; charset=utf-8'
        },
        body: jsonEncode(<String,dynamic>{
          "eid": id,
          "place": place,
          "role": role,
          "salery": sal

        }));
    return jsonDecode(res.body)["success"];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1),
          (){
          setState(() {
            fetch();
          });
        }
        );
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Text('+'),
          onPressed: () {
            setState(() {
              showModalBottomSheet(context: context, builder: (builder){
                return Container(
                  child: Center(
                    child: Column(
                      children: [
                        const Text('Add Employee'),
                        const SizedBox(height: 6,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Emp Id',
                              border: OutlineInputBorder()),
                          controller: ctlId,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Place',
                              border: OutlineInputBorder()),
                          controller: ctlPlace,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Role',
                              border: OutlineInputBorder()),
                          controller: ctlRole,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Salery',
                              border: OutlineInputBorder()),
                          controller: ctlSalery,),
                        ElevatedButton(onPressed: (){
                          int i=int.parse(ctlId.text);
                          int s = int.parse(ctlSalery.text);
                          setState(() {
                            comment=addValue(i, ctlPlace.text, ctlRole.text, s);
                            ctlRole.clear();
                            ctlPlace.clear();
                            ctlSalery.clear();
                            ctlId.clear();
                          });
                        }, child: const Text('Add')),
                      ],
                    ),
                  ),
                );
              });
            });
          },),
        body:
        FutureBuilder(
          future: fetch(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              List<ModalSp> l = snapshot.data;
              return Container(
                height: 800,
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: l.length,
                      itemBuilder: (BuildContext context,int i){
                        return Card(
                          child: ListTile(
                            leading: Text(l[i].eid.toString()),
                            title: Column(
                              children: [
                                Text(l[i].role!),
                                const SizedBox(height: 7,),
                                Text(l[i].place!)
                              ],
                            ),
                            trailing: Text(l[i].salery.toString()),
                          ),
                        );
                      }));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

        ),
      ),
    );
  }
}

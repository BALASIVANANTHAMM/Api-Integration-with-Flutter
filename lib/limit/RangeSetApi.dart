import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api/RangeApi.dart';

class RangeSetApi extends StatefulWidget {
  const RangeSetApi({super.key});

  @override
  State<RangeSetApi> createState() => _RangeSetApiState();
}

class _RangeSetApiState extends State<RangeSetApi> {
  final ctlRange = TextEditingController();
  Future<List<RangeApi>> fetch() async {
    var result = await http
        .get(Uri.parse("https://fakestoreapi.com/products?limit=${ctlRange.text}"));
    var data = jsonDecode(result.body);
    return (data as List).map((e) => RangeApi.fromJson(e)).toList();  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1.5,
        shadowColor: Colors.black12,
        toolbarHeight: 150,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: () {
                setState(() {
                  fetch;
                });
              }, icon: Icon(Icons.sticky_note_2),),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9)
              )
            ),
            controller: ctlRange,
          ),
        ),
      ),
    body: FutureBuilder(
      future: fetch(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
          List<RangeApi>? list = snapshot.data;
          return Expanded(
            child: ListView.builder(
              itemCount: list!.length,
                itemBuilder: (BuildContext context, int i){
              return ListTile(
                leading: Text(list[i].id.toString()),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list[i].title!),
                    Text(list[i].category!),
                    Text(list[i].description!),
                    Text(list[i].price!.toString(),style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                trailing: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(list[i].image!))
                  ),
                ),
              );
            }),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },),
    );
  }
}

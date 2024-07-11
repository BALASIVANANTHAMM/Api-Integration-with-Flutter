import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostAddElement extends StatefulWidget {
  const PostAddElement({super.key});

  @override
  State<PostAddElement> createState() => _PostAddElementState();
}

class _PostAddElementState extends State<PostAddElement> {
  final titleCtl = TextEditingController();
  final priceCtl = TextEditingController();
  final descCtl = TextEditingController();
  final catCtl = TextEditingController();
  String result = '';

  // Future<void> addCat(int id, String title,double price, String desc,String cat) async {
  //   var res = await http.post(
  //       Uri.parse(
  //           "https://fakestoreapi.com/products"),
  //       body: jsonEncode(<String, dynamic>{
  //         'id':id,
  //         'title': title,
  //         'price': price,
  //         'description': desc,
  //         'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
  //         'category': cat
  //       }));
  //   jsonDecode(res.body);
  // }
  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse("https://fakestoreapi.com/products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': titleCtl.text,
          'price': double.parse(priceCtl.text),
          'description': descCtl.text,
          'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
          'category': catCtl.text
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'ID: ${responseData['id']}\nTitle: ${responseData['title']}\nPrice: ${responseData['price']}';
          titleCtl.clear();
          priceCtl.clear();
          descCtl.clear();
          catCtl.clear();
        });
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
        titleCtl.clear();
        priceCtl.clear();
        descCtl.clear();
        catCtl.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: titleCtl,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: priceCtl,
          ),TextFormField(
            controller: descCtl,
          ),TextFormField(
            controller: catCtl,
          ),
          ElevatedButton(onPressed: _postData
            // double i = double.parse(priceCtl.text);
            // setState(() {
            //   _postData();
            //   // addCat(
            //   //     27,
            //   //     titleCtl.text,
            //   //     i,
            //   //     descCtl.text,
            //   //     catCtl.text);
            // });
          // }
          , child: Text('Add')),

          Text(result)
        ],
      ),
    );
  }
}

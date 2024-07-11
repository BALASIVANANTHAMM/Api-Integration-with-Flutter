import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CartsApi extends StatefulWidget {
  const CartsApi({super.key});

  @override
  State<CartsApi> createState() => _CartsApiState();
}
class _CartsApiState extends State<CartsApi> {
  String result ='';
  DateTime secondDate = DateTime.now();
  final uidCtl=TextEditingController();
  final pidCtl=TextEditingController();
  final qCtl=TextEditingController();
  Future<void> _cartAdd() async{
   try{
     var response = await http.post(
         Uri.parse("https://fakestoreapi.com/carts"),
         headers: <String,String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode(<String,dynamic>{
           'userId':int.parse(uidCtl.text),
           'date':'${secondDate.toLocal()}',
           'products':[
             {
               'productId':int.parse(pidCtl.text),
               'quantity':int.parse(qCtl.text)
             }]
         })
     );
     if (response.statusCode == 200) {
       final responseData = jsonDecode(response.body);
       setState(() {
         result='success';
         //result = 'User Id: ${responseData['userId']}\nDate: ${responseData['date']}\nProduct Id: ${responseData['products']['products'[0]]}\nQuantity: ${responseData['products']['products'[1]]}';
       });
     } else {
       throw Exception('Failed to post data');
     }
   }catch(e){
     setState(() {
       result='Error $e';
     });
   }
  }
  Future<void> _secondDatePick(BuildContext context) async {
    final DateTime? pickedSecond = await showDatePicker(
        context: context,
        initialDate: secondDate,
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2101));
    if (pickedSecond != null && pickedSecond != secondDate) {
      setState(() {
        secondDate = pickedSecond;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    String f='${secondDate.toLocal()}'.split(' ')[0];
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'User Id'
                ),
                controller: uidCtl,
              ),
            ),
            ElevatedButton(onPressed: (){
              _secondDatePick(context);
            }, child: Text('Pick Your Date')),
            Text(f),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Product Id'
                ),
                controller: pidCtl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Quantity'
                ),
                controller: qCtl,
              ),
            ),
            ElevatedButton(onPressed: _cartAdd, child: Text('Add Date To Cart')),
            Text(result)
          ],
        ),
      ),
    );
  }
}

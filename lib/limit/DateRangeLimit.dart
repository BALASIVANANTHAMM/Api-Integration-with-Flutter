import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api/DateSort.dart';

class DateRangeLimit extends StatefulWidget {
  const DateRangeLimit({super.key});

  @override
  State<DateRangeLimit> createState() => _DateRangeLimitState();
}

class _DateRangeLimitState extends State<DateRangeLimit> {
  DateTime firstDate = DateTime.now();

  Future<void> _firstDatePick(BuildContext context) async {
    final DateTime? pickedFirst = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2101));
    if (pickedFirst != null && pickedFirst != firstDate) {
      setState(() {
        firstDate = pickedFirst;
      });
    }
  }

  DateTime secondDate = DateTime.now();

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
  Future<List<DateSort>> fetch() async{
    String f='${firstDate.toLocal()}'.split(' ')[0];
    String e='${secondDate.toLocal()}'.split(' ')[0];
    var result = await http.get(Uri.parse("https://fakestoreapi.com/carts?startdate=$f&enddate=$e"));
    var data = jsonDecode(result.body);
    return (data as List).map((e) => DateSort.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${firstDate.toLocal()}'.split(' ')[0]),
            Text('${secondDate.toLocal()}'.split(' ')[0]),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _firstDatePick(context);
              });
            }, child: Text('Start'),

          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _secondDatePick(context);
              });
            }, child: Text('End'),

          ),
        ],
      ),
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, snapshot) {
          List<DateSort>? list = snapshot.data;
          if(snapshot.hasData){
            return Expanded(
                child: ListView.builder(
                  itemCount: list!.length,
                    itemBuilder: (BuildContext context,int i){
                      return ListTile(
                        leading: Text(list[i].id.toString()),
                        title: Text(list[i].date.toString()),
                      );
                    }));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },

      ),
      
    );
  }
}

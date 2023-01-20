import 'dart:convert';

import 'package:ecommerce/productpage.dart';
import 'package:ecommerce/qrcode.dart';
import 'package:ecommerce/qrread.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: qrread(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List list=[];
  List templist=[];
  //https://fakestoreapi.com/products/categories

get_categories() async {
    // var url = Uri.https('fakestoreapi.com', 'products/categories');
    var url = Uri.parse('https://fakestoreapi.com/products/categories');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  list=jsonDecode(response.body);
  templist=list;
  print(list);
  setState(() {

  });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List l=["electronics","jewelery","men's clothing","women's clothing","two","three","four","five"];
    print(l.where((element) => element.contains("f")));
    get_categories();
  }

  bool search=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search?
        AppBar(
        title: TextField(onChanged: (value) {
          print(value);
          templist=list.where((element) => element.toString().contains(value)).toList();
          print(templist);
          setState(() {

          });
        },),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              search=!search;

            });
          }, icon: Icon(Icons.cancel))
        ],
      ):
      AppBar(
        title: Text("Ecommerce",),
        actions: [
          IconButton(onPressed: () {

            setState(() {
              search=!search;

            });
          }, icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Text("Categories"),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text("${templist[index]}"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return productpage(templist[index]);
                },));
              },
            );
          },itemCount: templist.length,))
        ],
      ),
    );
  }
}

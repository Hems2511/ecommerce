import 'dart:convert';

import 'package:ecommerce/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class productpage extends StatefulWidget {
  String category;
  productpage(this.category);

  @override
  State<productpage> createState() => _productpageState();
}

class _productpageState extends State<productpage> {
  List list=[];
  List templist=[];
     get_products() async {
     // print('https://fakestoreapi.com/products/category/${widget.category}');
    var url = Uri.parse('https://fakestoreapi.com/products/category/${widget.category}');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
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

    // List l=[22,44,66,24,64,79,21,53,576];
    List l=["electronics","jewelery","men's clothing","women's clothing","two","three","four","five"];
    l.sort((a, b) => a.toString().compareTo(b.toString()));
    print(l);
    // l=l.reversed.toList();
    l.sort((b, a) => a.toString().compareTo(b.toString()));
    print(l);
    get_products();
  }
    bool search=false;
     int i=0;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: search?
      AppBar(
        title: TextField(onChanged: (value) {
          print(value);

          templist=list.where((element) => element['title'].toString().toLowerCase().contains(value.toLowerCase())).toList();
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
      body: ListView.builder(itemBuilder: (context, index) {

        Map m=templist[index];
        print(m);

        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return productDetails(m);
            },));
          },
          title: Text("${m['title']}"),
          subtitle: Text("${m['price']}"),
          leading: Image.network(m['image']),
        );
      },itemCount: templist.length,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            i=value;
            if(i==0)
              {
                templist.sort((a, b) => a['title'].toString().compareTo(b['title'].toString()),);
              }
            if(i==1)
            {
              templist.sort((b, a) => a['title'].toString().compareTo(b['title'].toString()),);
            }
            if(i==2)
            {
              templist.sort((a, b) => double.parse(a['price'].toString()).compareTo(double.parse(b['price'].toString())));
            }
            if(i==3)
            {
              templist.sort((b, a) => double.parse(a['price'].toString()).compareTo(double.parse(b['price'].toString())));
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "atoz"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "ztoa"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "ltoh"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "htol"),
        ],
      ),
    );
  }
}

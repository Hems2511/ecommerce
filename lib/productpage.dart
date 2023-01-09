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

    Future<List> get_products() async {
     // print('https://fakestoreapi.com/products/category/${widget.category}');
    var url = Uri.parse('https://fakestoreapi.com/products/category/${widget.category}');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    List list=jsonDecode(response.body);
    return list;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get_products();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: get_products(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          else
            {
              List? l=snapshot.data;
              return ListView.builder(itemBuilder: (context, index) {

                Map m=l[index];
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
              },itemCount: l!.length,);
            }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class productDetails extends StatefulWidget {

  Map m;
  productDetails(this.m);

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {

  double rate=0;
  int review=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rate=widget.m['rating']['rate'];
    review=widget.m['rating']['count'];
    rate=rate.toDouble();
    print(rate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network("${widget.m['image']}",height: 200,width: 200,),
          Text("${widget.m['title']}",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )),
          Text("${widget.m['description']}"),
          Text("Rs:${widget.m['price']}"),
          Text("$review Reviews"),
          RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          )
        ],

      ),
    );
  }
}

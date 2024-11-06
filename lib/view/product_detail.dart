import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/product_model.dart';
import 'bookking.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Products product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.partsName ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.partImage ?? 'https://via.placeholder.com/150',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 150),
            ),
            SizedBox(height: 16),
            Text(
              product.partsName ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Price: ${product.price ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Description: ${product.description ?? 'N/A'}'),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Rating: ${product.productRating ?? 'N/A'}'),
                Wrap(
                  children: [
                    Icon(Icons.star, color: Colors.yellow,size: 20.0,),
                    Icon(Icons.star, color: Colors.grey,size: 20.0,),Icon(Icons.star, color: Colors.grey,size: 20.0,),Icon(Icons.star, color: Colors.grey,size: 20.0,),
                    Icon(Icons.star_border, color: Colors.grey,size: 20.0,),
                  ],),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(onTap:() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => bookking()));
                  },
                    child: Container(
                      height: 40,width: 200,
                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.teal,),
                      child: Center(child: Text('Book Now')),
                    ),
                  ),

                ],
              ),


    ),
          ],
        ),
      ),
    );
  }
}

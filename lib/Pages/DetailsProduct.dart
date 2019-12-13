import 'package:api_calls/Models/Product.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  final String image;
  const DetailsPage({Key key, this.product, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Center(child: Text("Details du Produit")),
        ),
        body: Column(
          children: <Widget>[
            Align(
                child: Image(
              image: NetworkImage(
                image,
              ),
              width: 250,
              height: 250,
            )),
            SizedBox(
              height: 30,
            ),
            Text(
              product.titre,
              style: TextStyle(
                  fontSize: 25, color: Colors.red, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              product.description,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.prix + " ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.euro_symbol)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

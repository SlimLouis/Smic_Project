import 'dart:convert';

import 'package:api_calls/Models/Product.dart';
import 'package:api_calls/Pages/DetailsProduct.dart';
import 'package:flutter/material.dart';
import 'package:api_calls/Models/User.dart';
import 'package:api_calls/Providers/UserProvider.dart';

import 'package:provider/provider.dart';
import 'package:api_calls/Requests/GithubRequests.dart';

class FollowingPage extends StatefulWidget {
  final List data2;
  final User user;

  const FollowingPage({Key key, this.data2, this.user}) : super(key: key);
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  List<Product> products;
  var images = [
    "https://lactualite.com/assets/uploads/2011/06/une-pomme-par-jour.jpg",
    "https://www.lesfruitsetlegumesfrais.com/_upload/cache/ressources/produits/mangue/mangue_346_346_filled.jpg",
    "https://i.pinimg.com/originals/4f/c7/6a/4fc76adcd564b650e56aa427e83cdc1c.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    List data2 = widget.data2;
    User user = widget.user;
    show_fruit(index) {
      Product product = new Product(data2[index]['titre'],
          data2[index]['description'], data2[index]['prix']);
      String image = images[index];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    product: product,
                    image: image,
                  )));
    }

    setState(() {
      Github().fetchProducts(user.email, user.password).then((data) {
        Map<String, dynamic> ok = json.decode(data.body);
        data2 = ok["produits"];
      });
    });

    return Scaffold(
      body: Container(
        color: Colors.deepOrangeAccent,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<UserProvider>(context).setProduct(null);
                },
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 150,
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              "https://5.imimg.com/data5/WY/YU/MY-19876336/all-fruits-500x500.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Keep Calm",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Eat Me ",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 600,
                  child: data2 != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: data2.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(images[index]),
                              ),
                              title: Text(data2[index]["titre"]),
                              subtitle: Text(data2[index]['description']),
                              onTap: () {
                                show_fruit(index);
                              },
                              onLongPress: () {},
                            );
                          },
                        )
                      : Container(
                          child: Align(child: Text('Data is loading ...'))),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

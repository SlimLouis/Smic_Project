import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/User.dart';
import 'Providers/UserProvider.dart';
import 'Pages/FollowingPage.dart';

void main() => runApp(ChangeNotifierProvider<UserProvider>(
      builder: (context) => UserProvider(),
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController user_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  void _getUser() {
    if ((user_controller.text == '') && (password_controller.text == '')) {
      Provider.of<UserProvider>(context).setMessage("password empty");
      Provider.of<UserProvider>(context).setMessage2("login empty");
    } else {
      Provider.of<UserProvider>(context)
          .fetchUser(user_controller.text, password_controller.text)
          .then((value) {
        if (value) {
          List data2 = Provider.of<UserProvider>(context).getProduct();
          User user = Provider.of<UserProvider>(context).getUSer();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new FollowingPage(
                        data2: data2,user:user ,
                      )));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Container(
                height: 160,
                width: 160,
                child: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        "https://img.pngio.com/orange-juice-splash-png-download-mango-juice-splash-png-juice-splash-png-820_532.png")),
              ),
              SizedBox(height: 30),
              Text(
                "Fruity Fruits",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.1)),
                child: TextField(
                  onChanged: (value) {
                    Provider.of<UserProvider>(context).setMessage2(null);
                  },
                  controller: user_controller,
                  enabled: !Provider.of<UserProvider>(context).isLoading(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      errorText:
                          Provider.of<UserProvider>(context).getMessage2(),
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.1)),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    Provider.of<UserProvider>(context).setMessage(null);
                  },
                  controller: password_controller,
                  enabled: !Provider.of<UserProvider>(context).isLoading(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    
                      errorText:
                          Provider.of<UserProvider>(context).getMessage(),
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                height: 50.37,
                color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  _getUser();
                },
                child: Align(
                  child: Provider.of<UserProvider>(context).isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

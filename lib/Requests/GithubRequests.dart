import 'dart:convert';

import 'package:http/http.dart' as http;

class Github
{
  String api_url = "https://api.github.com/";
  String api_url2 = "http://siniway.com/Stage/connexion.php";
  String username; 
  String password;
  static String client_id ="3044fd7946dd16f71cd0";
  static String secret="68fb899adbe3880c99121b3608cdc10b2ec32ba1";
Github({this.username});

String query="?client_id=$client_id&client_secret=$secret";
  Future<http.Response> fetchUser()
  {
    return http.get(api_url+"users/$username"+query);
  }

  Future<http.Response> fetchFollowers()
  {
    return http.get(api_url+"users/$username/following"+query);
  }

Future<http.Response> fetchProducts(username,email)
{
  var data ={"username":username,"password":email};
  return http.post(api_url2,body: data );
}
}
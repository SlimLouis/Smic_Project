import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRequest {
  String api_url2 = "http://siniway.com/Stage/connexion.php";
  String username;
  String password;

  Future<http.Response> fetchProducts(username, email) {
    var data = {"username": username, "password": email};
    return http.post(api_url2, body: data);
  }
}

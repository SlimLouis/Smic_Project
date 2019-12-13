import 'dart:convert';

import 'package:api_calls/Models/Product.dart';
import 'package:api_calls/Requests/ApiRequest.dart';
import 'package:flutter/foundation.dart';

import 'package:api_calls/Models/User.dart';

class UserProvider with ChangeNotifier {
  User user;
  String errorMessage;
  String errorMessage2;
  bool loading = false;
  dynamic data;
  Product product;
  List product_;
  String email;
  String password;

  Future<bool> fetchUser(username, email) async {
    setLoading(true);

    await ApiRequest().fetchProducts(username, email).then((data) {
      setLoading(false);
      Map<String, dynamic> result = json.decode(data.body);
      if (data.statusCode == 200 &&
          result["message"] ==
              "Great success ! Merci de votre participation Mr Amir.") {
        // setUser(User.fromJson(json.decode(data.body)));
        User user = new User(username, email);
        setProduct(result["produits"]);
        setUser(user);
        return true;
      } else {
        setMessage(result['message']);
        return false;
      }
    });
    return isProduct();
  }

  void setData(value) {
    data = value;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  void setEmail(value) {
    email = value;
    notifyListeners();
  }

  void setPassword(value) {
    password = value;
    notifyListeners();
  }

  User getUSer() {
    return user;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  List getProduct() {
    return product_;
  }

  void setProduct(value) {
    product_ = value;
  }

  void setMessage2(value) {
    errorMessage2 = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  String getMessage2() {
    return errorMessage2;
  }

  dynamic getData() {
    return data;
  }

  bool isProduct() {
    return product_ != null ? true : false;
  }
}

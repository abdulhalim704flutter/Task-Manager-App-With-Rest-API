import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';

//Single responsibillity principle macanisume fllow
class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    // ? this is uses for , tis not uses every time, thats whay this is uses,
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {'token': AuthUtility.userInfo.token.toString()},
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        // this is write for, when status code is 401, then this is navigate in login page
        gotToLogoIn();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(
      // is login false this variable for , whene user enter wrong passwrod, then he will stand is login page, not through in 401
      String url,
      Map<String, dynamic> body,
      {bool islogin = false}) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'token': AuthUtility.userInfo.token.toString(),
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        if (islogin == false) {
          gotToLogoIn();
        }
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  //this funtion is write for , 401 server down,
  // when server is down ,then goto login screen , and clear cash storage
  Future<void> gotToLogoIn() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp
            .globalKey.currentContext!, //this is write for context calling
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}

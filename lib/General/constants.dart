

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL ="http://192.168.43.144:8080/";


Map<String, String>  HeadersPost;
Map<String, String> RequestHeaders;


setToken(String token){
  RequestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization':'Bearer ' + token,
  };

  HeadersPost = {
    'Content-type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'Authorization':'Bearer ' + token,
  };
}








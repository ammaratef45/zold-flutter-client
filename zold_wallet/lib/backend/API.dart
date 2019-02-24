import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class API {
  
  static const String BASE_URL = "https://wts.zold.io/";
  var client;

  API() {
    client = http.Client();
  }

  Future<String> getId(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}id";
    final response = await http.get(
      url,
      headers: headers
    );
    if(response.statusCode == 200) {
      return response.body.toString();
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> getBalance(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}balance";
    final response = await http.get(
      url,
      headers: headers,
    );
    if(response.statusCode == 200) {
      return response.body.toString();
    }
    throw Exception("Error: status code is not 200");
  }

  Future<String> pull(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}pull";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    if(response.statusCode == 302) {
      return "success";
    }
    throw new Exception("Error: status code is not 302");
  }

  Future<String> getCode(String phone) async {
    final url = "${BASE_URL}mobile/send?phone="+phone;
    final request = http.Request('GET', Uri.parse(url));
    final response = await client.send(request);
    if(response.statusCode == 200) {
      return "success";
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> getToken(String phone, String key) async {
    final url = "${BASE_URL}mobile/token?phone=" + phone + "&code=" + key;
    final request = http.Request('GET', Uri.parse(url));
    final response = await client.send(request);
    if(response.statusCode == 200) {
      return response.body().toString();
    }
    throw new Exception("Error: status code is not 200");
  }

}
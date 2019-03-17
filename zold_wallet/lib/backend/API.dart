import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;
import '../wts_log.dart';

class API {
  
  static const String BASE_URL = "https://wts.zold.io/";
  http.Client client;

  API() {
    client = http.Client();
  }

  Future<String> getId(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}id";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    http.StreamedResponse response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return responseData;
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> getBalance(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}balance?noredirect=1";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    http.StreamedResponse response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return responseData;
    }
    if(statusCode == 500) {
      return "pull";
    }
    throw Exception("Error: status code is not 200 or 500, it's $statusCode");
  }

  Future<String> pull(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}pull";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String job = response.headers["x-zold-job"].toString();
    String responseData = await response.stream.transform(utf8.decoder).join();

    if(statusCode == 302) {
      return job;
    }
    throw new Exception("Error: status code is not 302");
  }

  Future<String> getCode(String phone) async {
    final url = "${BASE_URL}mobile/send?phone="+phone + "&noredirect=1";
    final request = http.Request('GET', Uri.parse(url));
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return "success";
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> getToken(String phone, String key) async {
    final url = "${BASE_URL}mobile/token?phone=" + phone + "&code=" + key + "&noredirect=1";
    final request = http.Request('GET', Uri.parse(url));
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return responseData;
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> confirmed(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}confirmed?noredirect=1";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return responseData;
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> keygap(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}keygap";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return responseData;
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> confirm(String apiKey, String keygap) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}do-confirm?noredirect=1&keygap=$keygap";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String responseData = await response.stream.transform(utf8.decoder).join();
    if(statusCode == 200) {
      return "success";
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> pay(String bnf, String amount, String details, String apiKey, String keygap) async {
    var headers =  {
      "X-Zold-Wts": apiKey,
      "Content-Type": "application/x-www-form-urlencoded"
    };
    var body = "bnf=$bnf&amount=$amount&details=$details&keygap=$keygap";
    final url = "${BASE_URL}do-pay?noredirect=1";
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = body;
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String job = response.headers["x-zold-job"].toString();
    String responseData = await response.stream.transform(utf8.decoder).join();
    return job;
  }

  Future<WtsLog> output(String job, String apiKey) async {
    var headers =  {
      "X-Zold-Wts": apiKey
    };
    final url = "${BASE_URL}output?id=$job";
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.followRedirects = false;
    final response = await client.send(request);
    final statusCode = response.statusCode;
    String status = response.headers["x-zold-jobstatus"];
    String responseData = await response.stream.transform(utf8.decoder).join();
    return WtsLog(status, responseData);
  }

}
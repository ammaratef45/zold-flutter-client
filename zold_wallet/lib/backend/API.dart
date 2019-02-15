import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  
  static const String BASE_URL = "https://wts.zold.io/";

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
      headers: headers
    );
    if(response.statusCode == 200) {
      return response.body.toString();
    }
    throw new Exception("Error: status code is not 200");
  }

  Future<String> pull(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "${BASE_URL}pull";
    final response = await http.get(
      url,
      headers: headers
    );
    if(response.statusCode == 200) {
      return response.body.toString();
    }
    throw new Exception("Error: status code is not 200");
  }

}
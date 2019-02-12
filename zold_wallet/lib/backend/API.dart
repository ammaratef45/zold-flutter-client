import 'dart:async';
import 'package:http/http.dart' as http;

/*
* @todo #1 Add unit test for this class.
*  Should find a way to mock wallets first.
*  If not should search for another solution.
*/
class API {
  
  static const String BASE_URL = "https://wts.zold.io/";

  Future<String> getId(String apiKey) async {
    var headers =  {"X-Zold-Wts": apiKey};
    final url = "{$apiKey}id";
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
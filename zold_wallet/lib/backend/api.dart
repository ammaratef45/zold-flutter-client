import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zold_wallet/invoice.dart';
import 'package:zold_wallet/wts_log.dart';
import 'package:zold_wallet/job.dart';

import 'head.dart';

/// API helper class
class API {
  /// Constructor.
  API() {
    _client = http.Client();
  }
  static const String _baseURL = 'https://wts.zold.io/';
  http.Client _client;

  Map<String, String> _headers(String apiKey) =>
      <String, String>{'X-Zold-Wts': apiKey};

  /// Returns the id of the wallet.
  Future<String> getId(String apiKey) async {
    const String url = '${_baseURL}id';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Returns the balance of the wallet.
  Future<String> getBalance(String apiKey) async {
    const String url = '${_baseURL}balance?noredirect=1';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    if (statusCode == 500) {
      return 'pull';
    }
    throw Exception("status code is not 200 or 500, it's $statusCode");
  }

  /// Pulls the wallet from the network to wts server.
  Future<String> pull(String apiKey) async {
    const String url = '${_baseURL}pull';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String job = response.headers['x-zold-job'].toString();
    final String responseData =
        await response.stream.transform(utf8.decoder).join();

    if (statusCode == 302) {
      return job;
    }
    throw Exception('status code is not 302\n$responseData');
  }

  /// Destroys the wallet and recreates it.
  Future<String> recreate(String apiKey) async {
    const String url = '${_baseURL}create?noredirect=1';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();

    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Sends auth code to the phone number.
  Future<String> getCode(String phone) async {
    final String url = '${_baseURL}mobile/send?phone=$phone&noredirect=1';
    final http.Request request = http.Request('GET', Uri.parse(url))
      ..followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return 'success';
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Fetchs the rate of the zold.
  Future<String> rate() async {
    const String url = '${_baseURL}usd_rate';
    final http.Request request = http.Request('GET', Uri.parse(url))
      ..followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Get the API key using phone and auth code.
  Future<String> getToken(String phone, String key) async {
    final String url = '${_baseURL}mobile/token?phone=$phone'
        '&code=$key&noredirect=1';
    final http.Request request = http.Request('GET', Uri.parse(url))
      ..followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Checks if keygap is confirmed.
  Future<String> confirmed(String apiKey) async {
    const String url = '${_baseURL}confirmed?noredirect=1';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('Error: status code is not 200');
  }

  /// Retrieves keygap if not destroyed from wts server.
  Future<String> keygap(String apiKey) async {
    const String url = '${_baseURL}keygap';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return responseData;
    }
    throw Exception('Error: status code is not 200');
  }

  /// Confirm the keygap (should be destroyed in wts after it).
  Future<String> confirm(String apiKey, String keygap) async {
    final String url = '${_baseURL}do-confirm?noredirect=1&keygap=$keygap';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    if (statusCode == 200) {
      return 'success';
    }
    throw Exception('Error: status code is not 200\n$responseData');
  }

  /// Performs payment.
  Future<String> pay(String bnf, String amount, String details, String apiKey,
      String keygap) async {
    final Map<String, String> headers = _headers(apiKey);
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    final String body =
        'bnf=$bnf&amount=$amount&details=$details&keygap=$keygap';
    const String url = '${_baseURL}do-pay?noredirect=1';
    final http.Request request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = body
      ..followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final num statusCode = response.statusCode;
    final String job = response.headers['x-zold-job'].toString();
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    debugPrint(statusCode.toString());
    if (statusCode == 200) {
      return job;
    }
    throw Exception('status code is not 200\n$responseData');
  }

  /// Gets the output of a finished job.
  Future<WtsLog> output(String job, String apiKey) async {
    final String url = '${_baseURL}output?id=$job';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    //final num statusCode = response.statusCode;
    final String status = response.headers['x-zold-jobstatus'];
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    return WtsLog(status, responseData);
  }

  /// Gets information about the job.
  Future<Job> job(String job, String apiKey) async {
    final String url = '${_baseURL}job.json?id=$job';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    return Job.fromJson(json.decode(responseData));
  }

  /// Gets a new invoice.
  Future<Invoice> invoice(String apiKey) async {
    const String url = '${_baseURL}invoice.json';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final String responseData =
        await response.stream.transform(utf8.decoder).join();
    return Invoice.fromJson(json.decode(responseData));
  }

  /// Gets the list of transactions.
  Future<String> transactions(String apiKey) async {
    const String url = '${_baseURL}txns.json?sort=desc';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    if (response.statusCode != 200) {
      throw Exception('Status code is not 200');
    }
    return response.stream.transform(utf8.decoder).join();
  }

  /// Gets the head of wallet.
  Future<Head> head(String apiKey) async {
    const String url = '${_baseURL}head.json';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    if (response.statusCode != 200) {
      throw Exception('Status code is not 200');
    }
    return Head.fromJsonString(
        await response.stream.transform(utf8.decoder).join());
  }

  /// Downloads of wallet.
  Future<String> download(String apiKey) async {
    const String url = '${_baseURL}download';
    final http.Request request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(_headers(apiKey));
    request.followRedirects = false;
    final http.StreamedResponse response = await _client.send(request);
    final String responseString =
        await response.stream.transform(utf8.decoder).join();
    if (response.statusCode != 200) {
      throw Exception('Status code is not 200\n$responseString');
    }
    return responseString;
  }
}

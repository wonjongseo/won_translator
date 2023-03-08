import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translator_app/core/network_manager.dart';

String papaoUri = 'https://openapi.naver.com/v1/papago/n2mt';

class NetWork {
  static const String papagoBaseUrl =
      'https://openapi.naver.com/v1/papago/n2mt';
  //static const String papagoBaseUrl = 'http://localhost:3000/';
  //  static const String papagoBaseUrl =
  //     'https://won-translator.herokuapp.com/';

  NetworkManager networkManager = NetworkManager();
  Future<String> getWordMean(
      {required source, required target, required word}) async {
    // String source = 'en';
    // String target = 'ko';
    String id = '1FoeFZ9bzyTwWvE4A5pr';
    String secretKey = '5fL3KQQaTh';
    Map<String, dynamic> headers = {
      'X-Naver-Client-Id': id,
      'X-Naver-Client-Secret': secretKey,
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          true, // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    Map<String, dynamic> queryparameters = {
      'source': source,
      'target': target,
      'text': word
    };

    String url = '$papagoBaseUrl?source=$source&target=$target&text=$word';
    String result = '';
    try {
      http.Response res = await http.post(Uri.parse(url), headers: {
        'X-Naver-Client-Id': id,
        'X-Naver-Client-Secret': secretKey,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      });

      print('res: ${res.body}');

      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
  // Future<String> getWordMean(
  //     {required source, required target, required word}) async {
  //   Map<String, dynamic> headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //     'Access-Control-Allow-Origin': '*'
  //   };
  //   Map<String, dynamic> queryparameters = {
  //     'source': source,
  //     'target': target,
  //     'text': word
  //   };

  //   String result = '';
  //   try {
  //     final response = await networkManager.request(
  //         RequestMethod.get, papagoBaseUrl,
  //         queryparameters: queryparameters);

  //     if (response.data['message'] != null) {
  //       if (response.data['message']['result'] != null) {
  //         if (response.data['message']['result']['translatedText'] != null) {
  //           result = response.data['message']['result']['translatedText'];
  //         }
  //       }
  //     }
  //     return result;
  //   } catch (e) {
  //     print(e.toString());
  //     return e.toString();
  //   }
  // }

}

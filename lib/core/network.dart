import 'package:http/http.dart' as http;
import 'package:translator_app/core/network_manager.dart';

String papaoUri = 'https://openapi.naver.com/v1/papago/n2mt';

class NetWork {
  static const String papagoBaseUrl =
      'https://won-translator.herokuapp.com/translate';

  NetworkManager networkManager = NetworkManager();

  Future<String> getWordMean(
      {required source, required target, required word}) async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    };
    Map<String, dynamic> queryparameters = {
      'source': source,
      'target': target,
      'text': word
    };

    String result = '';
    try {
      final response = await networkManager.request(
          RequestMethod.get, papagoBaseUrl,
          queryparameters: queryparameters);

      if (response.data['message'] != null) {
        if (response.data['message']['result'] != null) {
          if (response.data['message']['result']['translatedText'] != null) {
            result = response.data['message']['result']['translatedText'];
          }
        }
      }
      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

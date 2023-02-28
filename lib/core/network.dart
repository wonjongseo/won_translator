import 'package:http/http.dart' as http;
import 'package:translator_app/core/network_manager.dart';

String papaoUri = 'https://openapi.naver.com/v1/papago/n2mt';

class NetWork {
  static const String papagoBaseUrl =
      'https://openapi.naver.com/v1/papago/n2mt';

  NetworkManager networkManager = NetworkManager();

  Future<String> getMean(
      {required source, required target, required word}) async {
    String id = '1FoeFZ9bzyTwWvE4A5pr';
    String secretKey = '5fL3KQQaTh';

    Map<String, dynamic> queryparameters = {
      'source': source,
      'target': target,
      'text': word
    };

    String url = '${papaoUri}?source=${source}&target=$target&text=$word';
    print('url: ${url}');

    try {
      http.Response res = await http.post(Uri.parse(papaoUri), headers: {
        'X-Naver-Client-Id': id,
        'X-Naver-Client-Secret': secretKey,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      });

      print(res.body);
    } catch (e) {
      print(e);
    }

    return '';
  }

  Future<String> getWordMean(
      {required source, required target, required word}) async {
    // String source = 'en';
    // String target = 'ko';
    String id = '1FoeFZ9bzyTwWvE4A5pr';
    String secretKey = '5fL3KQQaTh';

    Map<String, dynamic> headers = {
      'X-Naver-Client-Id': id,
      'X-Naver-Client-Secret': secretKey,
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Map<String, dynamic> queryparameters = {
      'source': source,
      'target': target,
      'text': word
    };

    String result = '';
    try {
      final response = await networkManager.request(
          RequestMethod.post, papagoBaseUrl,
          headers: headers, queryparameters: queryparameters);
      if (response.data['message'] != null) {
        if (response.data['message']['result'] != null) {
          if (response.data['message']['result']['translatedText'] != null) {
            result = response.data['message']['result']['translatedText'];
          }
        }
      }
      print(result);
      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

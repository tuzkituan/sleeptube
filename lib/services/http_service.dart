import 'package:http/http.dart' as http;
import 'package:sleeptube/utils/api.dart';

class HttpService {
  static Future<dynamic> getAPI(String url, final params) async {
    final uri = Uri.https(BASE_API, url, {...params, "key": API_KEY});
    return http
        .get(
      uri,
    )
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return response.body;
    });
  }

  // static Future<dynamic> postAPI(String url, Object payload) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = (prefs.getString('token') ?? "").toString();

  //   return http.post(
  //     Uri.https('link', url),
  //     body: json.encode(payload),
  //     headers: {
  //       'Content-Type': 'application/json;charset=UTF-8',
  //       'Access-Control-Allow-Origin': '*',
  //       'Authorization': 'Bearer $token',
  //     },
  //   ).then((http.Response response) {
  //     final int statusCode = response.statusCode;
  //     if (statusCode < 200 || statusCode > 400) {
  //       throw Exception("Error while calling API");
  //     }
  //     return response.body;
  //   });
  // }
}

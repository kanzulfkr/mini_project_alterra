import 'package:http/http.dart' as http;

class NetWorkHandler {
  static final client = http.Client();

  static Future<dynamic> get(String endpoint, String? token) async {
    var response = await client.get(buildUrl(endpoint), headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.body;
  }

  static Uri buildUrl(String endpoint) {
    String host = "https://webhook.site";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }
}

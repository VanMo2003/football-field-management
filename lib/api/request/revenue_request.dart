import 'package:http/http.dart' as http;

class RevenueRequest {
  static String url =
      'https://football-field-management.up.railway.app/revenue';

  static Future<String> getRevenueOfWeek(String nameFootballField) async {
    Uri uri = Uri.parse('${url}OfWeek/$nameFootballField');
    var reponse = await http.get(uri);

    return reponse.body;
  }
}

import 'package:http/http.dart' as http;

class RevenueRequest {
  static String url = 'http://10.0.2.2:8080/revenue';
  // 'https://football-field-management.up.railway.app/revenue';

  static Future<String> getRevenueOfWeek(String nameFootballField) async {
    Uri uri = Uri.parse('${url}OfWeek/$nameFootballField');
    var reponse = await http.get(uri);

    return reponse.body;
  }
}

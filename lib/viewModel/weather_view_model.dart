import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherViewModel {

  //WeatherViewModel(this.buildContext);

  Future<Map<String, dynamic>> sendRequest({latitude, longitude}) async {
    final url = Uri.parse('https://flexweather.com/api/now?lat=$latitude&lon=$longitude&units=metric');
    final headers = {'Accept': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to send message: ${response.statusCode}');
    }
  }
}
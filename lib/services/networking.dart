import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Data {
  final Uri url;

  Data(this.url);

  Future getData() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

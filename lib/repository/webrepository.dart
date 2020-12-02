
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sample_bloc/constants/constants.dart' as constant;
class WebRepository{
  Future<String> postData(String name,String price)async{
    String url = constant.URL;
    try {
      final http.Response response = await http.post(url,body: {
        "name": name,
        "price" : price,
      }).timeout(const Duration (seconds: 5));
      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      return null;
    }
  }
  Future<String> getData()async{
    String url = constant.URL+"get_services.php";
    try {
      final http.Response response = await http.post(url).timeout(const Duration (seconds: 5));
      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      return null;
    }
  }
}
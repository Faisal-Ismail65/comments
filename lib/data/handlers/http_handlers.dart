import 'dart:async';
import 'dart:convert';

import 'package:comments/data/exceptions/http_exceptions.dart';
import 'package:http/http.dart' as http;
class HttpHandlers{
   Future get(url,{required bool authorizationRequired}) async{
    var head = <String,String>{};
    head['content-type'] = 'application/json';

    var responseJson;
    try{
      final response = await http.get(Uri.parse(url), headers: head).timeout(const Duration(seconds: 20));
      responseJson = jsonDecode(response.body);
      print(responseJson);
      return responseJson;
    }on TimeoutException{
      throw FetchDataException('Slow internet connection');
    }
  }
}
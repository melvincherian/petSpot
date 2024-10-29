
import 'dart:convert';
import 'package:http/http.dart' as http;
class SmsApi{
  final String apiUrl;

  SmsApi(this.apiUrl);
  
  Future<bool>senSms(String to,String message)async{
  final response=await http.post(
    Uri.parse(apiUrl),
    headers: {'content-type':'application/json'},
    body: jsonEncode({'to':to,'message':message}),
  );
  if(response.statusCode==200){
     print('SMS send successfully');
     return true;

  }
  else{
    print('Failed to send SMS:${response.body}');
    return false;
  }
  }



}
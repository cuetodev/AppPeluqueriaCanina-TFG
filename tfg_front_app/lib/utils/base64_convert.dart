import 'dart:convert';

class Utils {

  static base64Encode(String term) {
    return base64.encode(utf8.encode(term));
  }

  static base64Decode(String term) {
    return utf8.decode(base64.decode(term)); 
  }

}
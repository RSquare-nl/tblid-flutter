import 'dart:convert';

class PostVars {
  var postVars = new Map();

  void add(String key,String value){
    postVars[key]=value;
  }

  String get(String key){
    return postVars[key];
  }

  String getJsonString(){
    return json.encode(postVars).toString();
  }

  void parseJsonString(String jsonString){
    postVars=json.decode(jsonString);
  }
}
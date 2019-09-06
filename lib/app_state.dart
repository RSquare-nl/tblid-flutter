import 'package:flutter/material.dart';

import 'postVars.dart';

class AppState extends InheritedWidget {

  String barcode = "";
  String url = "";
  final String rsaUrl = "http://tblid.nl/wp-json/tblid/v1/RSAGenerator";
  String domainname = "a";
  String jsontext = "none";
  String httphttps = "http(s)";
  String webPubKey = "webpubkey";
  String localEmail = "localEmail";
  String localPubKey = "localPubKey";
  String localPrivKey = "localPrivKey";

  PostVars postVars = PostVars();


  AppState({Key key,Widget child}) : super(key:key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

    static AppState of(BuildContext context) =>
        context.inheritFromWidgetOfExactType(AppState);

}
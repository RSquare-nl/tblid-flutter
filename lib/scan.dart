import 'dart:async';
import 'app_state.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tblid_flutter/postVars.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:basic_utils/src/model/RRecord.dart';
import 'package:basic_utils/src/model/RRecordType.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:http/http.dart'  as http;
import 'package:tblid_flutter/database_helpers.dart';


//import "package:pointycastle/api.dart";
import "package:pointycastle/digests/sha512.dart";

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {



  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: postLogin,
                    child: const Text('LOGIN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).barcode, textAlign: TextAlign.center,),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).url, textAlign: TextAlign.center,),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).domainname, textAlign: TextAlign.center,),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).jsontext, textAlign: TextAlign.center,),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).httphttps, textAlign: TextAlign.center,),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(AppState.of(context).webPubKey, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    Uri uri;

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        AppState.of(context).barcode = barcode;
        uri=Uri.parse(barcode);
        AppState.of(context).domainname = uri.host;
        AppState.of(context).httphttps= uri.scheme;
        AppState.of(context).url= uri.origin+uri.path;

        if(uri.hasQuery) {
//          postVars.addmap(uri.queryParameters);
        }
        AppState.of(context).postVars.add("sid",uri.queryParameters["sid"]);
        AppState.of(context).postVars.add("username", "loginTextP6");
        AppState.of(context).postVars.add("action", "login");

        AppState.of(context).jsontext= AppState.of(context).postVars.getJsonString();


        getPublicKey(AppState.of(context).domainname);

      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          AppState.of(context).barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => AppState.of(context).barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => AppState.of(context).barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => AppState.of(context).barcode = 'Unknown error: $e');
    }
  }

  Future getPublicKey(String domainname) async {
    String buff;
    List<RRecord> records = await DnsUtils.lookupRecord("_tblid."+domainname,RRecordType.TXT);
    if(records.elementAt(0).data.isNotEmpty==true) {
      buff = records
          .elementAt(0)
          .data
          .toString();
      int pos;
      int pos2;
      pos= buff.indexOf("sha512=");
      pos2= buff.length-pos-7-1;

      String a=buff.substring(pos+7);
      String b='';
      a=a.substring(0,(a.length-1));
      a=a.replaceAll('"', '');
      String pem= '-----BEGIN PUBLIC KEY-----\n';
      while(a.length>0){
        if(a.length>=64) {
          pem += a.substring(0, 64) + '\n';
          a = a.substring(64);
        }else {
          pem += a + '\n';
          a = '';
        }
      }
      pem+='-----END PUBLIC KEY-----';

      AppState.of(context).webPubKey=pem;
        setState(() {

        });

    }
  }

  Future postLogin() async {
    final parser = RSAKeyParser();
    final RSAPublicKey publicKey = parser.parse(AppState.of(context).webPubKey);

    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(AppState.of(context).jsontext);

    var client = new  http.Client();
    try {

      var uriResponse = await client.post(AppState.of(context).url,
          body: {'data': encrypted.base64 });
     // http.Response str = await client.get(uriResponse.body);
    } finally {
      client.close();
    }
  }

  _save(Keys key) async{
  //Save keys

  DatabaseHelper helper = DatabaseHelper.instance;
   await helper.insert(key);
}

  _read(String url) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Keys key = await helper.queryKey(url);
    if (url == null) {
      //Generate keys and save
      Keys key = Keys();
      key.url=url;
      key.email = '';
      key.pubkey = '';
      key.privkey='';
      var client = new  http.Client();
         http.Response str = await client.get(AppState.of(context).rsaUrl);

        JsonDecoder decoder;
        var vars = new Map();
        vars = decoder.convert(str.toString());
        key.pubkey = vars['pubkey'];
        key.privkey=vars['privkey'];
        _save(key);
        client.close();
    } else {
      AppState.of(context).localPubKey=key.pubkey;
      AppState.of(context).localPrivKey=key.privkey;
    }
  }
}
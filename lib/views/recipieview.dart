import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RecipieView extends StatefulWidget{
  final String postUrl;
RecipieView({this.postUrl});
  _RecipieViewState createState()=>_RecipieViewState();
}
class _RecipieViewState extends State<RecipieView>{
   final Completer<WebViewController> _controller =Completer<WebViewController>();
    String finalUrl ;
    void initState() {
    
    super.initState();
    finalUrl = widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }

  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: Platform.isIOS? 60: 30, right: 24,left: 24,bottom: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xff213A50),
                        const Color(0xff071930)
                      ],
                     )),
              child:  Row(
                mainAxisAlignment: kIsWeb
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "AppGuy",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                    ),
                  ),
                  Text(
                    "Recipes",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        ),
                  )
                ],
              ),
            ),
Container(height: MediaQuery.of(context).size.height-100,
//width: MediaQuery.of(context).size.width,
padding: EdgeInsets.symmetric(horizontal:15),
  child:
   WebView(
  initialUrl:finalUrl,
  javascriptMode:JavascriptMode.unrestricted,
   onWebViewCreated: (WebViewController webViewController){
                  setState(() {
                    _controller.complete(webViewController);
                  });}
)

     ) ])));
  }
}
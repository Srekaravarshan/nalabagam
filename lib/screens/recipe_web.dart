import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeWebview extends StatefulWidget {
  final String url;
  final String title;

  const RecipeWebview({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _RecipeWebviewState createState() => _RecipeWebviewState();
}

class _RecipeWebviewState extends State<RecipeWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        elevation: 1,
        title: Text(widget.title, style: const TextStyle(color: Colors.black),),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
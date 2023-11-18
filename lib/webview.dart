import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pilih Gambar dari Web'),
      content: Container(
        height: 400,
        width: 300,
        child: WebView(
          initialUrl: 'https://www.google.com',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
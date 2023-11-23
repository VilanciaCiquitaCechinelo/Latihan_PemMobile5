import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewDialog extends StatefulWidget {
  @override
  _CustomWebViewDialogState createState() => _CustomWebViewDialogState();
}

class _CustomWebViewDialogState extends State<CustomWebViewDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('WebView'),
      content: Container(
        height: 300,
        width: double.maxFinite,
        child: WebView(
          initialUrl: 'https://www.google.com', // Ganti dengan URL yang diinginkan
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
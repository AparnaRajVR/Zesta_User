import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BotpressChatbotPage extends StatelessWidget {
  const BotpressChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('https://cdn.botpress.cloud/webchat/v2.5/shareable.html?configUrl=https://files.bpcontent.cloud/2025/06/04/03/20250604035436-35K5NGNQ.json'),
        ),
      ),
    );
  }
}

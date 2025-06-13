// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class BotpressChatbotPage extends StatelessWidget {
//   const BotpressChatbotPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chatbot')),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(
//           url: WebUri('https://cdn.botpress.cloud/webchat/v2.5/shareable.html?configUrl=https://files.bpcontent.cloud/2025/06/04/03/20250604035436-35K5NGNQ.json'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:zesta_1/constant/color.dart'; // Use your app's color constants

class BotpressChatbotPage extends StatefulWidget {
  const BotpressChatbotPage({super.key});

  @override
  State<BotpressChatbotPage> createState() => _BotpressChatbotPageState();
}

class _BotpressChatbotPageState extends State<BotpressChatbotPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot', style: TextStyle(color: AppColors.textlight,fontWeight:FontWeight.bold),), // Use your app's text color
        backgroundColor: AppColors.primary, // Use your app's primary color
        foregroundColor: AppColors.textlight, // Use your app's text color
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://cdn.botpress.cloud/webchat/v2.5/shareable.html?configUrl=https://files.bpcontent.cloud/2025/06/04/03/20250604035436-35K5NGNQ.json'),
            ),
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
            // Optionally, you can use onProgressChanged for finer control
            // onProgressChanged: (controller, progress) {
            //   setState(() {
            //     _isLoading = progress < 100;
            //   });
            // },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                // Add more options as needed
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.primary, // Match your app's color
              ),
            ),
        ],
      ),
      backgroundColor: AppColors.textaddn, // Match your app's background
    );
  }
}

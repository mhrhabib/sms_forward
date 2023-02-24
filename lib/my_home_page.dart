import 'package:flutter/material.dart';
import 'package:sms_sender/sm_handler.dart';
import 'package:telephony/telephony.dart';

import 'api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String sms = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listen Incoming SMS in Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "The number is",
              style: TextStyle(fontSize: 30),
            ),
            const Divider(),
            Text(
              cellNumber,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

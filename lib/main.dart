import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';

import 'my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBackground.initialize();
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "You have a message",
    notificationText: "Background message",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  if (success) {
    await FlutterBackground.enableBackgroundExecution();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Support Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

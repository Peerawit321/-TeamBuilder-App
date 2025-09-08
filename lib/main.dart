import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'team_controller.dart';
import 'team_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TeamController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Builder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TeamPage(),
    );
  }
}

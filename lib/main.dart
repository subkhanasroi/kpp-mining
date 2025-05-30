import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      debugShowCheckedModeBanner: false,
      title: 'LedakIn',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 238, 238),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

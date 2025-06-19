import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/splash_screen.dart';
import 'package:kppmining_calculator/ui/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // ← Bahasa Indonesia
        Locale('en'), // (opsional)
      ],
      home: const SplashScreen(),
    );
  }
}

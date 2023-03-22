import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/responsive/mobile_screen_layout.dart';
import 'package:uniconnect/responsive/responsive_layout_screen.dart';
import 'package:uniconnect/responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBuZeCsxa5hZGxE59Nxngd9G0Ue4O_VG_w',
          appId: '1:187717066638:web:6aa322172fd6fbb1994edf',
          messagingSenderId: '187717066638',
          projectId: 'uniconnect-62628',
          storageBucket: 'uniconnect-62628.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniConnect',
      theme: ThemeData.dark(),
      home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()),
    );
  }
}

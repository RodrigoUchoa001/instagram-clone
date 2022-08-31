import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  // INICIAR USO DO FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // PRA RODAR NA WEB
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAggGeswNELanWog5q8ApaBU4_1ddbMfaM',
        appId: '1:40971141199:web:47618cf151f42cbc20ea3a',
        messagingSenderId: '40971141199',
        projectId: 'instagram-clone-flutter-70379',
        storageBucket: 'instagram-clone-flutter-70379.appspot.com',
      ),
    );
  } else {
    // PRA RODAR NO ANDROID
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
  // CONTINUAR A PARTIR DA CRIACAO DA TELA DE LOGIN
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayoutScreen(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}

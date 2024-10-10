import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';  // Thêm import màn hình đăng nhập

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());  // Bỏ từ khóa 'const' ở đây
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // Bỏ 'const' ở đây
      debugShowCheckedModeBanner: false,
      home: CustomLoginPage(),  // Thay thế bằng LoginPage
    );
  }
}

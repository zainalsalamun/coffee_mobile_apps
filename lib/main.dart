// lib/main.dart
import 'package:coffe_mobile_apps/modules/home/home_page.dart';
import 'package:coffe_mobile_apps/modules/menu/equipment_page.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'modules/auth/login_page.dart';
import 'modules/auth/register_page.dart';
import 'modules/menu/menu_page.dart';
import 'modules/menu/persediaan_page.dart';
import 'modules/profile/edit_profile_page.dart';
import 'modules/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma Design App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),

      // 👇 MULAI DARI SPLASH
      initialRoute: '/',

        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/edit-profile': (context) => const EditProfilePage(),
            '/menu': (context) => const MenuPage(),
          '/equipment': (context) => const EquipmentPage(),
          '/persediaan': (context) => const PersediaanPage(),

        }

    );
  }
}

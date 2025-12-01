// lib/main.dart
import 'package:coffe_mobile_apps/modules/home/home_page.dart';
import 'package:coffe_mobile_apps/modules/menu/equipment_page.dart';
import 'package:coffe_mobile_apps/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'modules/auth/login_page.dart';
import 'modules/auth/register_page.dart';
import 'modules/menu/menu_page.dart';
import 'modules/menu/persediaan_page.dart';
import 'modules/profile/edit_profile_page.dart';
import 'modules/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
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

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/menu': (context) => const MenuPage(),
        '/equipment': (context) => const EquipmentPage(),
        '/persediaan': (context) => const PersediaanPage(),
      },
    );
  }
}

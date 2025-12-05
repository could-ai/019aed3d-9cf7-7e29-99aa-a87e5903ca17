import 'package:flutter/material.dart';
import 'screens/main_layout.dart';

void main() {
  runApp(const RobloxCloneApp());
}

class RobloxCloneApp extends StatelessWidget {
  const RobloxCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roblox Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF191B1D), // Roblox Dark Theme Background
        primaryColor: const Color(0xFF232527), // Roblox Dark Theme Secondary
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(0xFF00B06F), // Roblox Green (often used for play buttons)
          surface: Color(0xFF232527),
          background: Color(0xFF191B1D),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF232527),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF232527),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainLayout(),
      },
    );
  }
}

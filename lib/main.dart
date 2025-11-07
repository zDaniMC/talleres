import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/lifecycle_screen.dart';
import 'screens/grid_tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (c) => const HomeScreen(),
        '/detalle': (c) => const DetailScreen(message: "JOSE DANIEL RIVAS"),
        '/ciclo': (c) => const LifecycleScreen(),
        '/grid': (c) => const GridTabScreen(),
      },
    );
  }
}

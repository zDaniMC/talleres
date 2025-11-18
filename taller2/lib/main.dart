import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const SegundoPlanoApp());
}

class SegundoPlanoApp extends StatelessWidget {
  const SegundoPlanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Segundo Plano - José Daniel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.teal,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _resultado = "Presiona un botón para ejecutar la tarea...";

  // Simulación con Future
  Future<void> ejecutarFuture() async {
    setState(() => _resultado = "Ejecutando Future...");
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _resultado = "✅ Future completado después de 2 segundos");
  }

  // Simulación con Timer
  void ejecutarTimer() {
    setState(() => _resultado = "Ejecutando Timer...");
    Timer(const Duration(seconds: 3), () {
      setState(() => _resultado = "⏰ Timer finalizado después de 3 segundos");
    });
  }

  // Simulación con Isolate
  Future<void> ejecutarIsolate() async {
    setState(() => _resultado = "Ejecutando Isolate...");
    final receivePort = ReceivePort();
    await Isolate.spawn(_procesoPesado, receivePort.sendPort);
    receivePort.listen((mensaje) {
      setState(() => _resultado = mensaje);
      receivePort.close();
    });
  }

  static void _procesoPesado(SendPort sendPort) {
    int suma = 0;
    for (int i = 0; i < 200000000; i++) {
      suma += i;
    }
    sendPort.send("💪 Isolate completado: suma = $suma");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segundo Plano - José Daniel"),
        centerTitle: true,
        backgroundColor: Colors.tealAccent.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.tealAccent.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
              ),
              child: Text(
                _resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(Icons.flash_on, "Future", ejecutarFuture),
                _buildButton(Icons.timer, "Timer", ejecutarTimer),
                _buildButton(Icons.memory, "Isolate", ejecutarIsolate),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

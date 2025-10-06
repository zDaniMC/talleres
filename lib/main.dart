import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const TallerSegundoPlanoApp());
}

class TallerSegundoPlanoApp extends StatelessWidget {
  const TallerSegundoPlanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller Segundo Plano',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    AsyncExampleScreen(),
    TimerScreen(),
    IsolateScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Taller Segundo Plano")),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Future'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'Isolate'),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

// ---------------------- 1️⃣ Future / async / await ----------------------

class AsyncExampleScreen extends StatefulWidget {
  const AsyncExampleScreen({super.key});

  @override
  State<AsyncExampleScreen> createState() => _AsyncExampleScreenState();
}

class _AsyncExampleScreenState extends State<AsyncExampleScreen> {
  String _status = "Presiona para cargar datos";

  Future<void> _loadData() async {
    print("Antes del Future");
    setState(() => _status = "Cargando datos...");

    try {
      final data = await Future.delayed(
        const Duration(seconds: 3),
            () => "✅ Datos cargados correctamente",
      );
      print("Durante el Future");
      setState(() => _status = data);
    } catch (e) {
      setState(() => _status = "❌ Error al cargar datos");
    }

    print("Después del Future");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_status, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text("Cargar datos"),
          ),
        ],
      ),
    );
  }
}

// ---------------------- 2️⃣ Timer (cronómetro) ----------------------

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${_seconds}s",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(onPressed: _startTimer, child: const Text("Iniciar")),
              ElevatedButton(onPressed: _pauseTimer, child: const Text("Pausar")),
              ElevatedButton(onPressed: _resetTimer, child: const Text("Reiniciar")),
            ],
          )
        ],
      ),
    );
  }
}

// ---------------------- 3️⃣ Isolate ----------------------

void heavyTask(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 500000000; i++) {
    sum += i;
  }
  sendPort.send(sum);
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  String _result = "Presiona para iniciar tarea pesada";

  Future<void> _startIsolate() async {
    setState(() => _result = "Procesando en segundo plano...");

    final receivePort = ReceivePort();
    await Isolate.spawn(heavyTask, receivePort.sendPort);

    receivePort.listen((message) {
      setState(() => _result = "✅ Resultado: $message");
      print("Tarea pesada completada: $message");
      receivePort.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_result, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startIsolate,
            child: const Text("Iniciar tarea pesada"),
          ),
        ],
      ),
    );
  }
}

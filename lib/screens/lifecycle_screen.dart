import 'package:flutter/material.dart';

class LifecycleScreen extends StatefulWidget {
  const LifecycleScreen({super.key});

  @override
  State<LifecycleScreen> createState() => _LifecycleScreenState();
}

class _LifecycleScreenState extends State<LifecycleScreen>
    with WidgetsBindingObserver {
  String estado = 'Iniciando...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    estado = 'initState ejecutado';
    print(" initState ejecutado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(" didChangeDependencies ejecutado");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print(" dispose ejecutado");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      estado = 'Estado cambiado: $state';
    });
    print(" didChangeAppLifecycleState: $state");
  }

  @override
  Widget build(BuildContext context) {
    print(" build ejecutado");
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Ciclo de Vida')),
      body: Center(
        child: Text(
          estado,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

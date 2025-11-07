import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/dog_service.dart';

class DogListView extends StatefulWidget {
  const DogListView({super.key});

  @override
  State<DogListView> createState() => _DogListViewState();
}

class _DogListViewState extends State<DogListView> {
  final DogService service = DogService();
  bool loading = true;
  String? error;
  List<String> breeds = [];

  @override
  void initState() {
    super.initState();
    loadBreeds();
  }

  Future<void> loadBreeds() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final list = await service.getBreeds();
      setState(() {
        breeds = list;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Razas de perros')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: loadBreeds, child: const Text('Reintentar')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Razas de perros')),
      body: ListView.builder(
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          final breed = breeds[index];
          return ListTile(
            title: Text(breed),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.pushNamed('detalle', params: {'breed': breed}),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/dog_service.dart';

class DogDetailView extends StatefulWidget {
  final String breed;
  const DogDetailView({super.key, required this.breed});

  @override
  State<DogDetailView> createState() => _DogDetailViewState();
}

class _DogDetailViewState extends State<DogDetailView> {
  final DogService service = DogService();
  String? imageUrl;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    try {
      final url = await service.getRandomImage(widget.breed);
      setState(() {
        imageUrl = url;
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.breed)),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : error != null
                ? Text('Error: $error')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (imageUrl != null)
                        Image.network(imageUrl!, height: 300, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text('Raza: ${widget.breed}', style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: loadImage,
                        child: const Text('Ver otra imagen'),
                      ),
                    ],
                  ),
      ),
    );
  }
}

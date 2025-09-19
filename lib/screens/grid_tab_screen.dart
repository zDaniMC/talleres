import 'package:flutter/material.dart';

class GridTabScreen extends StatelessWidget {
  const GridTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Grid y Tabs"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_on), text: "Grid"),
              Tab(icon: Icon(Icons.list), text: "Lista"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _GridSection(),
            _ListSection(),
          ],
        ),
      ),
    );
  }
}

class _GridSection extends StatelessWidget {
  const _GridSection();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue[100 * ((index % 8) + 1)],
          child: Center(child: Text("Item ${index + 1}")),
        );
      },
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text("Elemento 1")),
        ListTile(title: Text("Elemento 2")),
        ListTile(title: Text("Elemento 3")),
      ],
    );
  }
}

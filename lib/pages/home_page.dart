import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var items = ['Item 1', 'Item 2', 'Item 3'];

  Widget _buildItem(int index) {
    return Card(
      elevation: 15,
      child: ListTile(
        title: Text(items[index]),
      ),
    );
  }

  Widget _itemBuilderSlide(context, index, animation) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: _buildItem(index),
    );
  }

  Widget _itemBuilderFade(context, index, animation) {
    return FadeTransition(
      opacity: animation.drive(
        Tween<double>(
          begin: 0,
          end: 1,
        ),
      ),
      child: _buildItem(index),
    );
  }

  Widget _buildList() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: items.length,
      itemBuilder: _itemBuilderSlide,
    );
  }

  Widget _buildListlivew() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _buildItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
        centerTitle: true,
      ),
      body: _buildList(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              items.add('Item ${items.length + 1}');
              _listKey.currentState!.insertItem(
                items.length - 1,
                duration: const Duration(
                  milliseconds: 500,
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _listKey.currentState!.removeItem(
                items.length - 1,
                (context, animation) =>
                    _itemBuilderFade(context, items.length - 1, animation),
                duration: const Duration(milliseconds: 800),
              );
              items.removeLast();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

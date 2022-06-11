import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'book_list_model.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.read(bookProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          if (book.books == null) {
            return const CircularProgressIndicator();
          }
          final List<Widget> widgets = book.books!
              .map(
                (book) => ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                ),
              )
              .toList();
          return ListView(
            children: widgets,
          );
        },
      )),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

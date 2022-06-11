import 'package:book_list_riverpod_sample_app/presentation/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBookPage extends ConsumerWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addBook = ref.watch(addBookProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      addBook.title = text;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      addBook.author = text;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await addBook
                            .addBook()
                            .then((value) => Navigator.of(context).pop());
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('本を追加'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

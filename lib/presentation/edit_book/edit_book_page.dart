import 'package:book_list_riverpod_sample_app/presentation/edit_book/edit_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/book.dart';

class EditBookPage extends ConsumerWidget {
  const EditBookPage(this.book, {super.key});
  final Book book;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addBook = ref.watch(editBookProvider(book));
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
                    controller: addBook.titleController,
                    decoration: const InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      addBook.setTitle(text);
                    },
                  ),
                  TextField(
                    controller: addBook.authorController,
                    decoration: const InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      addBook.setAuthor(text);
                    },
                  ),
                  ElevatedButton(
                    onPressed: addBook.isUpdated()
                        ? () async {
                            try {
                              await addBook
                                  .addBook()
                                  .then((value) => Navigator.of(context).pop());
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: const Text('本を編集'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

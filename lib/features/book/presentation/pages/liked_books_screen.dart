import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class LikedBooksScreen extends StatelessWidget {
  const LikedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<BookBloc>(context)..add(FetchLikedBooks()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Liked Books')),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LikedBooksLoaded) {
              if (state.books.isEmpty) {
                return const Center(child: Text('No liked books.'));
              }
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return ListTile(
                    leading: book.coverImage != null
                        ? Image.network(
                            book.coverImage!,
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.book, size: 50),
                    title: Text(book.title),
                    subtitle: Text(book.authors.join(', ')),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<BookBloc>().add(DislikeBook(book.id));
                      },
                    ),
                    onTap: () => context.go('/detail/${book.id}'),
                  );
                },
              );
            } else if (state is BookError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

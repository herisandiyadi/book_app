import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book_entity.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;
  const BookDetailScreen({super.key, required this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_changed);
        return false;
      },
      child: Builder(
        builder: (context) {
          // Always fetch the latest detail when opening
          context.read<BookBloc>().add(GetBookDetail(widget.bookId));
          return BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is BookDetailLoaded) {
                final BookEntity book = state.book;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(book.title),
                    actions: [
                      IconButton(
                        icon: Icon(
                          book.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: book.isLiked ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            _changed = true;
                          });
                          if (book.isLiked) {
                            context.read<BookBloc>().add(DislikeBook(book.id));
                          } else {
                            context.read<BookBloc>().add(LikeBook(book.id));
                          }
                        },
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        if (book.coverImage != null)
                          Center(
                            child: Image.network(
                              book.coverImage!,
                              width: 150,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          book.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'By: ${book.authors.join(', ')}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        if (book.description != null)
                          Text(
                            book.description!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                      ],
                    ),
                  ),
                );
              } else if (state is BookError) {
                return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: Text('Error: ${state.message}')),
                );
              } else {
                return const Scaffold(body: SizedBox.shrink());
              }
            },
          );
        },
      ),
    );
  }
}

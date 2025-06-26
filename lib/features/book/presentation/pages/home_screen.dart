import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import '../../../../route_observer.dart';

import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  String? _currentQuery;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    // Unsubscribe from route changes
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when coming back to this screen
    refreshPage();
  }

  void refreshPage() {
    context.read<BookBloc>().add(FetchBooks(page: 1, query: _currentQuery));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        context.read<BookBloc>().state is BookLoaded) {
      final state = context.read<BookBloc>().state as BookLoaded;
      if (!state.hasReachedMax) {
        context.read<BookBloc>().add(
          FetchMoreBooks(page: state.currentPage + 1, query: _currentQuery),
        );
      }
    }
  }

  void _onSearch(String query) {
    _currentQuery = query;
    context.read<BookBloc>().add(SearchBooks(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palm Book App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () async {
              await context.push('/liked');
              if (!mounted) return;
              context.read<BookBloc>().add(
                FetchBooks(page: 1, query: _currentQuery),
              );
            },
            tooltip: 'Liked Books',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _onSearch,
            ),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookLoading && _currentPage == 1) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookLoaded) {
                  if (state.books.isEmpty) {
                    return const Center(child: Text('No books found.'));
                  }
                  _currentPage = state.currentPage;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.books.length
                        : state.books.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= state.books.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
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
                          icon: Icon(
                            book.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: book.isLiked ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (book.isLiked) {
                              context.read<BookBloc>().add(
                                DislikeBook(book.id),
                              );
                            } else {
                              context.read<BookBloc>().add(LikeBook(book.id));
                            }
                          },
                        ),
                        onTap: () async {
                          final result = await context.push(
                            '/detail/${book.id}',
                          );
                          if (!mounted) return;
                          if (result == false) {
                            refreshPage();
                          }
                        },
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
        ],
      ),
    );
  }

  // (Removed duplicate dispose)
}

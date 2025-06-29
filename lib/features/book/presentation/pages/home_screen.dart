import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../route_observer.dart';
import 'package:palm_book_app/app.dart';

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
    _searchController.clear();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFF00FFF7), Color(0xFF9D00FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Palm Book App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Color(0xFF00FFF7)),
            onPressed: () async {
              await context.push('/liked');
              if (!mounted) return;
              context.read<BookBloc>().add(
                FetchBooks(page: 1, query: _currentQuery),
              );
            },
            tooltip: 'Liked Books',
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeSwitcher.of(context).themeMode,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark
                      ? const Color(0xFF00FFF7)
                      : const Color(0xFF9D00FF),
                ),
                tooltip: isDark
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
                onPressed: () {
                  ThemeSwitcher.of(context).themeMode.value = isDark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? const LinearGradient(
                  colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFE3F6FF), Color(0xFFFFFFFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search books...',
                        prefixIcon: const Icon(Icons.search),
                        // Use theme's InputDecorationTheme for fillColor and border
                      ),
                      onSubmitted: _onSearch,
                    ),
                    const SizedBox(height: 8),
                    // (Filter bar removed)
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookLoading && _currentPage == 1) {
                      // Shimmer loading list
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 70,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: double.infinity,
                                  height: 16,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: 100,
                                  height: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is BookLoaded) {
                      if (state.books.isEmpty) {
                        return const Center(child: Text('No books found.'));
                      }
                      _currentPage = state.currentPage;
                      return GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.62,
                            ),
                        itemCount:
                            (state.hasReachedMax || state.books.length == 1)
                            ? state.books.length
                            : state.books.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.books.length) {
                            // Jangan tampilkan loading widget jika hasil search hanya 1 item
                            if (state.books.length == 1) {
                              return const SizedBox.shrink();
                            }
                            // Shimmer loading card for infinite scroll
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 220,
                                  padding: const EdgeInsets.all(12),
                                ),
                              ),
                            );
                          }
                          final book = state.books[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).colorScheme.surface,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.10),
                                  blurRadius: 16,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
                                final result = await context.push(
                                  '/detail/${book.id}',
                                );
                                log('BACKDATA $result');
                                if (!mounted) return;
                                if (result == true || result == false) {
                                  refreshPage();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF00FFF7,
                                              ).withOpacity(0.3),
                                              blurRadius: 16,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: book.coverImage != null
                                              ? CachedNetworkImage(
                                                  imageUrl: book.coverImage!,
                                                  width: 90,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                        baseColor: Theme.of(
                                                          context,
                                                        ).colorScheme.surface,
                                                        highlightColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                  0.3,
                                                                ),
                                                        child: Container(
                                                          width: 90,
                                                          height: 120,
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.surface,
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (
                                                        context,
                                                        url,
                                                        error,
                                                      ) => Icon(
                                                        Icons.broken_image,
                                                        size: 50,
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                      ),
                                                )
                                              : Icon(
                                                  Icons.book,
                                                  size: 50,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      book.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                            shadows: [
                                              Shadow(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Color(0xFF9D00FF),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            book.authors.isNotEmpty
                                                ? (book.authors.length == 1
                                                      ? book.authors.first.name
                                                      : '${book.authors.first.name} +${book.authors.length - 1}')
                                                : 'Unknown Author',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  fontSize: 12,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w500,
                                                  shadows: [
                                                    Shadow(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(0.3),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        icon: Icon(
                                          book.isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: book.isLiked
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.error
                                              : Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          shadows: [
                                            Shadow(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          if (book.isLiked) {
                                            context.read<BookBloc>().add(
                                              DislikeBook(book),
                                            );
                                          } else {
                                            context.read<BookBloc>().add(
                                              LikeBook(book),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
        ),
      ),
    );
  }

  // (Removed duplicate dispose)
}

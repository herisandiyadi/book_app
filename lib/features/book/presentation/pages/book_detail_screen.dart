import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  ValueNotifier<bool>? _isLikedNotifier;
  int? _lastBookId;

  @override
  void initState() {
    super.initState();
    // Fetch detail hanya sekali saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookBloc>().add(GetBookDetail(widget.bookId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_changed);
        return false;
      },
      child: BlocListener<BookBloc, BookState>(
        listenWhen: (previous, current) => current is BookDetailLoaded,
        listener: (context, state) {
          if (state is BookDetailLoaded) {
            // Sinkronkan ValueNotifier dengan state global
            if (_isLikedNotifier != null) {
              _isLikedNotifier!.value = state.book.isLiked;
            }
          }
        },
        child: BlocBuilder<BookBloc, BookState>(
          buildWhen: (prev, curr) =>
              curr is BookLoading ||
              curr is BookDetailLoaded ||
              curr is BookError,
          builder: (context, state) {
            if (state is BookLoading) {
              // Shimmer detail
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 150,
                            height: 200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 120,
                          height: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        4,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is BookDetailLoaded) {
              // Simpan data ke variabel lokal agar tidak ikut rebuild
              final BookEntity book = state.book;
              // ignore: prefer_final_locals
              var _localBook = book;
              // Inisialisasi ValueNotifier hanya jika bookId berubah
              if (_isLikedNotifier == null || _lastBookId != book.id) {
                _isLikedNotifier?.dispose();
                _isLikedNotifier = ValueNotifier<bool>(book.isLiked);
                _lastBookId = book.id;
              }
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(),

                  title: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [Color(0xFF00FFF7), Color(0xFF9D00FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      _localBook.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  actions: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _isLikedNotifier!,
                      builder: (context, isLiked, _) {
                        return IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked
                                ? const Color(0xFFFF005C)
                                : const Color(0xFF00FFF7),
                            shadows: [
                              Shadow(
                                color: Color(0xFF9D00FF),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _isLikedNotifier?.value = !isLiked;
                            if (isLiked) {
                              context.read<BookBloc>().add(
                                DislikeBook(_localBook),
                              );
                            } else {
                              context.read<BookBloc>().add(
                                LikeBook(_localBook),
                              );
                            }
                            setState(() {
                              _changed = true;
                            });
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
                            colors: [Color(0xFF0A0F2C), Color(0xFF9D00FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFF2F6FF), Color(0xFF00FFF7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                  child: _BookDetailContent(book: _localBook),
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
        ),
      ),
    );
  }
}

class _BookDetailContent extends StatelessWidget {
  final BookEntity book;
  const _BookDetailContent({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.98),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
              blurRadius: 24,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              if (book.coverImage != null)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00FFF7).withOpacity(0.3),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: book.coverImage!,
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Theme.of(context).colorScheme.surface,
                        highlightColor: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.3),
                        child: Container(
                          width: 150,
                          height: 200,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image,
                        size: 150,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Theme.of(context).colorScheme.secondary,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (book.authors.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Authors:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...book.authors.map(
                      (a) => Text(
                        '${a.name}'
                        '${a.birthYear != null ? ' (b. ${a.birthYear})' : ''}'
                        '${a.deathYear != null ? ' - d. ${a.deathYear}' : ''}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              if (book.summaries != null && book.summaries!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Summary:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                ...book.summaries!.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      s,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
              if (book.description != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Description:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  book.description!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
              if (book.subjects != null && book.subjects!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Subjects:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 6,
                  children: book.subjects!
                      .map(
                        (s) => Chip(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          label: Text(
                            s,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (book.bookshelves != null && book.bookshelves!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Bookshelves:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 6,
                  children: book.bookshelves!
                      .map(
                        (s) => Chip(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          label: Text(
                            s,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (book.languages != null && book.languages!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Languages:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 6,
                  children: book.languages!
                      .map(
                        (l) => Chip(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          label: Text(
                            l,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (book.copyright != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Copyright: ${book.copyright == true ? "Yes" : "No"}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (book.mediaType != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Media Type: ${book.mediaType}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (book.formats != null && book.formats!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Formats:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                ...book.formats!.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.key,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Open link
                              // (implement open url if needed)
                            },
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (book.downloadCount != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Download Count: ${book.downloadCount}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

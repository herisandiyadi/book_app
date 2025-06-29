import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palm_book_app/features/book/presentation/pages/home_screen.dart';
import 'package:palm_book_app/features/book/presentation/pages/book_detail_screen.dart';
import 'package:palm_book_app/features/book/presentation/pages/liked_books_screen.dart';
import 'package:palm_book_app/features/book/presentation/bloc/book_bloc.dart';
import 'package:palm_book_app/injection/injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await init();

  runApp(const PalmBookWidgetbook());
}

class PalmBookWidgetbook extends StatelessWidget {
  const PalmBookWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        theme: ThemeData.light(),
      ),
      directories: [
        WidgetbookFolder(
          name: 'Pages',
          children: [
            WidgetbookComponent(
              name: 'HomeScreen',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => BlocProvider<BookBloc>(
                    create: (_) => sl<BookBloc>(),
                    child: HomeScreen(),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'BookDetailScreen',
              useCases: [
                WidgetbookUseCase(
                  name: 'BookId 1',
                  builder: (context) => BlocProvider<BookBloc>(
                    create: (_) => sl<BookBloc>(),
                    child: BookDetailScreen(bookId: 1),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'LikedBooksScreen',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => BlocProvider<BookBloc>(
                    create: (_) => sl<BookBloc>(),
                    child: LikedBooksScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

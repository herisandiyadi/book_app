import 'package:get_it/get_it.dart';
import '../features/book/data/datasource/remote_datasource.dart';
import '../features/book/data/datasource/local_datasource.dart';
import '../features/book/data/repository/book_repository_impl.dart';
import '../features/book/domain/repository/book_repository.dart';

// Import usecases
import '../features/book/domain/usecases/get_books.dart';
import '../features/book/domain/usecases/get_book_detail.dart';
import '../features/book/domain/usecases/like_book.dart';
import '../features/book/domain/usecases/dislike_book.dart';
import '../features/book/domain/usecases/get_liked_books.dart';

// Import BookBloc
import '../features/book/presentation/bloc/book_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton(() => BookRemoteDataSource());
  sl.registerLazySingleton(() => BookLocalDataSource());

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Usecases
  sl.registerLazySingleton<GetBooks>(() => GetBooks(sl()));
  sl.registerLazySingleton<GetBookDetail>(() => GetBookDetail(sl()));
  sl.registerLazySingleton<LikeBook>(() => LikeBook(sl()));
  sl.registerLazySingleton<DislikeBook>(() => DislikeBook(sl()));
  sl.registerLazySingleton<GetLikedBooks>(() => GetLikedBooks(sl()));

  // Bloc
  sl.registerFactory(
    () => BookBloc(
      getBooks: sl(),
      getBookDetail: sl(),
      likeBook: sl(),
      dislikeBook: sl(),
      getLikedBooks: sl(),
    ),
  );
}

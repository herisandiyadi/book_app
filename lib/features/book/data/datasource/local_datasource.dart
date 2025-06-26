import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/book_model.dart';

class BookLocalDataSource {
  static const String _dbName = 'books.db';
  static const String _tableName = 'liked_books';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            title TEXT,
            authors TEXT,
            cover_image TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> likeBook(BookModel book) async {
    final db = await database;
    await db.insert(_tableName, {
      'id': book.id,
      'title': book.title,
      'authors': book.authors.join(','),
      'cover_image': book.coverImage,
      'description': book.description,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> dislikeBook(int id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<BookModel>> getLikedBooks() async {
    final db = await database;
    final maps = await db.query(_tableName);

    return maps.map((map) {
      return BookModel(
        id: map['id'] as int,
        title: map['title'] as String,
        authors: (map['authors'] as String).split(','),
        coverImage: map['cover_image'] as String?,
        description: map['description'] as String?,
      );
    }).toList();
  }

  Future<bool> isBookLiked(int id) async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty;
  }
}

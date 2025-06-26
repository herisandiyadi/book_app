import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection/injection.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'production.env');
  await init();
  F.appFlavor = Flavor.production;
  runApp(const App());
}

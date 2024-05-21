import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mrwebbeast/services/database/local_database.dart";
import "package:provider/provider.dart";
import "package:mrwebbeast/app.dart";
import "features/products/controllers/products_controller.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsController()),
      ],
      child: const MyApp(),
    ),
  );
}

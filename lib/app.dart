import "package:flutter/material.dart";
import "package:mrwebbeast/core/routes/route_screens.dart";
import "package:mrwebbeast/core/config/app_config.dart";
import "package:mrwebbeast/utils/theme/theme_controller.dart";

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme(context),
      routeInformationParser: RoutesScreens.router.routeInformationParser,
      routerDelegate: RoutesScreens.router.routerDelegate,
      routeInformationProvider: RoutesScreens.router.routeInformationProvider,
    );
  }
}

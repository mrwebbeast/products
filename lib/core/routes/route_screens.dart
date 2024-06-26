import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";

import "package:mrwebbeast/app.dart";

import "package:mrwebbeast/core/routes/route_configs.dart";

import "../../features/products/view/products_view.dart";

class RoutesScreens {
  /// Initial Route...
  // static final _settingsNavigatorKey = GlobalKey<NavigatorState>();

  static String? initialLocation() {
    // bool authenticated = isAuthenticated();
    return Routes.products;
  }

  ///1)  Route Config...

  static final GoRouter _router = GoRouter(
    initialLocation: initialLocation(),
    navigatorKey: MyApp.navigatorKey,
    routes: [
      GoRoute(
        name: Routes.products,
        path: Routes.products,
        pageBuilder: (context, state) {
          return materialPage(state: state, child: const ProductsView());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return unknownRoute(context: context, state: state);
    },
    redirectLimit: 1,
  );

  static GoRouter get router => _router;

  ///2)  Unknown Route...

  static MaterialPage unknownRoute({
    required BuildContext context,
    required GoRouterState state,
  }) {
    return MaterialPage(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("No Route defined for unknown  ${state.path}")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              color: context.colorScheme.primary,
              child: const Text("Home"),
              onPressed: () {
                context.go(Routes.products);
              },
            ),
          ),
        ],
      ),
    ));
  }

  static authRedirect(BuildContext context, GoRouterState state) {}

  ///3)  Material Page ...

  static MaterialPage<dynamic> materialPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return MaterialPage(key: state.pageKey, child: child);
  }

  ///4)  Cupertino Page...
  static CupertinoPage<dynamic> cupertinoPage({
    required GoRouterState state,
    required Widget child,
    bool authRequired = false,
  }) {
    return CupertinoPage(key: state.pageKey, child: child);
  }

  ///5)  Cupertino Page...

  static CustomTransitionPage<dynamic> customTransitionPage({
    required GoRouterState state,
    required Widget child,
    bool authRequired = false,
    Curve? curve,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool opaque = true,
    bool barrierDismissible = false,
    Color? barrierColor,
    String? barrierLabel,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      barrierDismissible: barrierDismissible,
      opaque: opaque,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: curve ?? Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}

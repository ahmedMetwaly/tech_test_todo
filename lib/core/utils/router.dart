

import '../../features/home/presentation/pages/home.dart';
import '../../features/splash_screen/presentation/pages/splash_screen.dart';
import 'routes.dart';
import "package:flutter/material.dart";
class RoutesGeneratour {
  static Route<dynamic> getRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
     
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
   
      default:
        return unFoundedRoute();
    }
  }

  static Route<dynamic> unFoundedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title:const Text("No Route")),
              body: const Center(child: Text("Error: this page is not found")),
            ));
  }
}

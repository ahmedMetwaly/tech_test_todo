import 'package:flutter/material.dart';
import 'core/utils/router.dart';
import 'core/utils/routes.dart';
import 'core/utils/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeManager.lightTheme,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: (settings) => RoutesGeneratour.getRoute(settings),
    );
  }
}

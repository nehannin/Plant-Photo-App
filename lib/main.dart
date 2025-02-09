import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/plant_provider.dart';

void main() {
  runApp(MyApp());
}

/// The main app widget, which sets up the theme and state management.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Provides `PlantProvider` to the widget tree, allowing state management.
      create: (_) => PlantProvider(),
      child: MaterialApp(
        title: 'Plant Photo App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange[600]),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
            titleLarge: TextStyle(
              color: Colors.white, 
              fontSize: 28, 
              fontWeight: FontWeight.bold, 
            ),
          ),
          buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
          scaffoldBackgroundColor: Color.fromARGB(255, 230, 224, 206),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 218, 131, 1),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

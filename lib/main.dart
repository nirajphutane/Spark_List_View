import 'package:flutter/material.dart';
import 'package:spark_list_view/home.dart';

void main() {
  Application.run();
}

class Application{
  static run() async {
    runApp(
      MaterialApp(
        title: 'Spark',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColorLight: Colors.orange[300],
          primaryColor: Colors.orange,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.orange,
            secondary: Colors.green,
          ),
        ),
        home: Home(),
      )
    );
  }
}
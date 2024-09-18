import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/route/app_route.dart';



void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
     initialRoute: AppRoute.movieSearchPage,
          getPages: AppRoute.pages,
    );
  }
}

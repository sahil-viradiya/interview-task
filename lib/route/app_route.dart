import 'package:get/get.dart';
import 'package:movie_app/screens/movie/movie_details_page.dart';
import 'package:movie_app/screens/movie/movie_search_page.dart';

class AppRoute {
  static String movieSearchPage = '/movie_search_page';
  static String movieDetailsPage = '/movie_details_page';

  static List<GetPage> pages = [
    GetPage(
      name: movieSearchPage,
      page: () => MovieSearchPage(),
    ),
    GetPage(
      name: movieDetailsPage,
      page: () => MovieDetailsPage(),
    )
  ];
}

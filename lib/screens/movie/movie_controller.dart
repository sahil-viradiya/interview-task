import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/movie/repo/movie_repository.dart';
import 'package:movie_app/utils/connectivity_service.dart';

class MovieController extends GetxController {
  final MovieRepository repository;
  var isLoading = false.obs;
  var movies = [].obs;
  var page = 1.obs;
  final query = ''.obs;
  var isConnected = true.obs;

  final ConnectivityService connectivityService = ConnectivityService();

  var hasMore = true.obs;

  MovieController({required this.repository}) {
    connectivityService.onConnectivityChanged.listen((result) {
      isConnected.value = result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi;
      if (isConnected.value) {
        searchMovies(
            query.value); // Retry fetching movies if connection is restored
      } else {
        Get.snackbar('No Internet', 'Please check your network connection.');
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  // Search movies with auto-search and pagination
  void searchMovies(String newQuery) async {
    if (query.value != newQuery) {
      query.value = newQuery;
      page.value = 1;
      movies.clear();
      hasMore.value = true;
    }

    if (newQuery.isEmpty) {
      return;
    }

    isLoading.value = true;

    try {
      final result = await repository.searchMovies(newQuery, page.value);
      if (result.isEmpty) {
        hasMore.value = false;
      }
      movies.addAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void fetchMoreData({required String query}) async {
    // Replace with actual API call to fetch more data
    final newItems = await repository.searchMovies(query, page.value + 1);
    if (newItems.isEmpty) {
      hasMore.value = false;
    }
    movies.addAll(newItems);
    page.value++;
    update();
  }
}

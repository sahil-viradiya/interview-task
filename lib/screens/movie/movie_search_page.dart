import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/route/app_route.dart';
import 'package:movie_app/screens/movie/movie_controller.dart';
import 'package:movie_app/screens/movie/repo/movie_repository.dart';
import 'package:movie_app/widgets/custome_textfeild.dart';

class MovieSearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final MovieController _movieController =
      Get.put(MovieController(repository: MovieRepository()));
  final RxString searchText = ''.obs;

  MovieSearchPage({super.key}); // Observable for debouncing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor2,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        centerTitle: true,
        title: const Text(
          'Movie Search',
          style: TextStyle(
              color: ColorConstant.kWhite, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFilledTextFormFieldWidget(
              controller: _controller,
              onchanged: (val) {
                searchText.value = val!;
              },
              hintText: "Search for movies...",
            ),
          ),

          // Use Obx to reactively handle search and loading state
          Obx(() {
            debounce(searchText, (val) {
              _movieController.searchMovies(searchText.value);
            }, time: const Duration(milliseconds: 500));

            return Expanded(
              child: _movieController.movies.isEmpty
                  ? const Center(
                      child: Text("Please Search Movie"),
                    )
                  : _movieController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _movieController.movies.length + 1,
                          itemBuilder: (context, index) {
                            if (index == _movieController.movies.length) {
                              if (_movieController.hasMore.value) {
                                _movieController.fetchMoreData(
                                    query: searchText.value);
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return const SizedBox
                                    .shrink(); // Use SizedBox.shrink() instead of Container()
                              }
                            }

                            final movie = _movieController.movies[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.movieDetailsPage,
                                    arguments: movie);
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.kWhite,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 18,
                                              spreadRadius: 2,
                                              color: ColorConstant.primaryColor.withOpacity(0.5),
                                              offset: const Offset(0, 0)),
                                        ],
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    movie['title'],
                                    style: TextStyle(
                                        color: ColorConstant.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          }),
            );
          }),
        ],
      ),
    );
  }
}

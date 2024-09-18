import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constant/color_constant.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = Get.arguments;

    return Scaffold(
      backgroundColor: ColorConstant.primaryColor2,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor2,
        iconTheme: const IconThemeData(color: ColorConstant.kWhite),
        title: Text(
          movie['title'],
          style: const TextStyle(
              color: ColorConstant.kWhite, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                  fit: BoxFit.cover,
                  height: 350,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Relese Date : ${movie['release_date']}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  movie['overview'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

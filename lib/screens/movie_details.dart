import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_poster/models/movie.dart';

import '../constants.dart';

class MovieDetails extends StatelessWidget {
  static String routeName = "movie-details";
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final indexDetailedMovie = args['id'];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(Movie.movies[indexDetailedMovie!].title),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onVerticalDragStart: (details) {
              print(details);
            },
            onVerticalDragUpdate: (details) {
              print(details.delta.dy);
              if (details.delta.dy > 0) {
                Navigator.of(context).pop();
              }
            },
            child: SizedBox(
              width: size.width,
              height: size.height * 0.45,
              child: Hero(
                tag: Movie.movies[indexDetailedMovie!].title,
                child: Image.asset(
                  Movie.movies[indexDetailedMovie].assetName,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 1.5, horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "movie_title",
                      child: Text(
                        Movie.movies[indexDetailedMovie].title,
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                            color: kPrimaryDarkColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Hero(
                      tag: "movie_comming_date",
                      child: Text(
                        Movie.movies[indexDetailedMovie].commingDate,
                        style: GoogleFonts.nunito(
                            color: kPrimaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: "rating_hero",
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ...List.generate(
                          Movie.stars.length,
                          (index) => Icon(
                            Icons.star,
                            color: index <=
                                    Movie
                                        .movies[indexDetailedMovie].ratingStars!
                                ? Colors.yellow
                                : Colors.yellow.withOpacity(0.6),
                            size: index <=
                                    Movie
                                        .movies[indexDetailedMovie].ratingStars!
                                ? 22.0
                                : 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: kDefaultPadding,
                    left: kDefaultPadding,
                    right: kDefaultPadding),
                child: Text(
                  Movie.movies[indexDetailedMovie].description!,
                  style: GoogleFonts.nunito(
                    color: kBlackColor,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
          // ListTile(
          //   title: Text(
          //     Movie.movies[indexDetailedMovie].title,
          //     maxLines: 1,
          //     style: GoogleFonts.nunito(
          //         color: kPrimaryDarkColor,
          //         fontSize: 20.0,
          //         fontWeight: FontWeight.w700),
          //   ),
          //   subtitle: Text(
          //     Movie.movies[indexDetailedMovie].commingDate,
          //     style: GoogleFonts.nunito(
          //         color: kPrimaryColor,
          //         fontSize: 14.0,
          //         fontWeight: FontWeight.w400),
          //   ),
          //   trailing: Hero(
          //     tag: "rating_hero",
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         ...List.generate(
          //           Movie.movies[indexDetailedMovie].ratingStars!,
          //           (index) => Icon(
          //             Icons.star,
          //             color: Colors.yellow,
          //             size: 20.0*1.35
          //           ),
          //         ),
          //         ...List.generate(
          //           (Movie.stars.length - Movie.movies[indexDetailedMovie].ratingStars!),
          //         (index) => Icon(
          //           Icons.star,
          //           color: Colors.yellow.withOpacity(0.6),
          //           size: 20.0,
          //         ),
          //       ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

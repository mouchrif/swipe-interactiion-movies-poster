import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_poster/models/movie.dart';

import '../constants.dart';

class MovieInfos extends StatelessWidget {
  final double pageTxt;
  final PageController pageTxtCtrl;
  const MovieInfos({Key? key, 
  required this.pageTxt, 
  required this.pageTxtCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PageView.builder(
              controller: pageTxtCtrl,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: Movie.movies.length,
              itemBuilder: (context, index) {
                final opacity = (1 - (index - pageTxt).abs()).clamp(0.0, 1.0);
                return Opacity(
                  opacity: opacity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "movie_title",
                        child: Text(
                          Movie.movies[index].title,
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
                          Movie.movies[index].commingDate,
                          style: GoogleFonts.nunito(
                              color: kPrimaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_poster/constants.dart';
import 'package:movie_poster/models/movie.dart';
import 'package:movie_poster/screens/movie_details.dart';
import 'package:movie_poster/widgets/movie_infos.dart';
import 'package:movie_poster/widgets/movie_rating.dart';

class DisplayPosters extends StatefulWidget {
  DisplayPosters({Key? key}) : super(key: key);
  @override
  _DisplayPostersState createState() => _DisplayPostersState();
}

class _DisplayPostersState extends State<DisplayPosters>
    with TickerProviderStateMixin {
  final GlobalKey<MovieRatingState> _movieRatingStateKey = GlobalKey();
  int indexMovie = 0;
  double _pageText = 0.0;

  List<int> _listIndexMovie = [
    Movie.movies[0].ratingStars!,
    Movie.movies[0].ratingStars!
  ];

  PageController? _pageTextController = PageController();

  void _textScrollListener(int index) {
    setState(() {
      _pageText = index.toDouble();
    });
  }

  @override
  void initState() {
    super.initState();
    _pageTextController!.addListener(() => _textScrollListener(indexMovie));
  }

  @override
  void dispose() {
    _pageTextController!.removeListener(() => _textScrollListener(indexMovie));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: kDefaultPadding / 1.5),
          child: Swiper(
            itemWidth: size.width - 2 * size.width * 0.1,
            itemHeight: size.height * 0.65,
            layout: SwiperLayout.STACK,
            itemCount: Movie.movies.length,
            itemBuilder: (context, index) => Card(
              shadowColor: kSecondaryLightColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      MovieDetails.routeName,
                      arguments: {
                        "id": indexMovie,
                      }
                  );
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Hero(
                      tag: Movie.movies[index],
                      child: Image.asset(
                          Movie.movies[index].assetName,
                          fit: BoxFit.fill,
                        ),
                    ),
                    ),
              ),
            ),
            onIndexChanged: (index) {
              setState(() {
                indexMovie = index;
              });
              if (index < Movie.movies.length) {
                _pageTextController!.animateToPage(index,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutCubic);
              }
              if (_listIndexMovie.length < 2) {
                _listIndexMovie.add(Movie.movies[indexMovie].ratingStars!);
              } else {
                _listIndexMovie.removeAt(0);
                _listIndexMovie.add(Movie.movies[indexMovie].ratingStars!);
              }
              _movieRatingStateKey.currentState!
                  .forwardAndReverseAnimationStars();
            },
          ),
        )),
        SizedBox(
          height: size.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding / 2,
            ),
            child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: MovieInfos(
                        pageTxt: _pageText,
                        pageTxtCtrl: _pageTextController!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: MovieRating(
                      key: _movieRatingStateKey,
                      indexMovie: indexMovie,
                      listIndexMovie: _listIndexMovie),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

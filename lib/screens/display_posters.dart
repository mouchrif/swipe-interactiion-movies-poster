import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_poster/constants.dart';
import 'package:movie_poster/models/movie.dart';

class DisplayPosters extends StatefulWidget {
  const DisplayPosters({Key? key}) : super(key: key);

  @override
  _DisplayPostersState createState() => _DisplayPostersState();
}

class _DisplayPostersState extends State<DisplayPosters>
    with TickerProviderStateMixin {
  int _indexMovie = 0;
  double _pageText = 0.0;
  
  List<int> _listIndexMovie = [
    Movie.movies[0].ratingStars!,
    Movie.movies[0].ratingStars!
  ];
  
  AnimationController? _animController;
  
  PageController? _pageTextController = PageController();
  
  Animation<double>? animStar1Scale;
  Animation<double>? animStar2Scale;
  Animation<double>? animStar3Scale;
  Animation<double>? animStar4Scale;
  Animation<double>? animStar5Scale;

  Animation<double>? _getAnimation(int index) {
    if (index == 0) {
      return animStar1Scale;
    }
    if (index == 1) {
      return animStar2Scale;
    }
    if (index == 2) {
      return animStar3Scale;
    }
    if (index == 3) {
      return animStar4Scale;
    }
    if (index == 4) {
      return animStar5Scale;
    }
  }

  void _textScrollListener(int index) {
    setState(() {
      _pageText = index.toDouble();
    });
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    animStar1Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.ease,
      ),
      // reverseCurve: Interval(0.0, 0.2, curve: Curves.ease),
    ));
    animStar2Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.ease,
      ),
      // reverseCurve: Interval(0.2, 0.4, curve: Curves.ease),
    ));
    animStar3Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.ease,
      ),
      // reverseCurve: Interval(0.4, 0.6, curve: Curves.ease),
    ));
    animStar4Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.ease,
      ),
      // reverseCurve: Interval(0.6, 0.8, curve: Curves.ease),
    ));
    animStar5Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.8,
        1.0,
        curve: Curves.ease,
      ),
      // reverseCurve: Interval(0.8, 1.0, curve: Curves.ease),
    ));
    _pageTextController!.addListener(() => _textScrollListener(_indexMovie));
  }

  @override
  void dispose() {
    _animController!.dispose();
    _pageTextController!.removeListener(() => _textScrollListener(_indexMovie));
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
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    Movie.movies[index].assetName,
                    fit: BoxFit.fill,
                  )),
            ),
            onIndexChanged: (index) {
              setState(() {
                _indexMovie = index;
              });
              if (index < Movie.movies.length) {
                _pageTextController!.animateToPage(index,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutCubic);
              }
              if (_listIndexMovie.length < 2) {
                _listIndexMovie.add(Movie.movies[_indexMovie].ratingStars!);
              } else {
                _listIndexMovie.removeAt(0);
                _listIndexMovie.add(Movie.movies[_indexMovie].ratingStars!);
              }
              if (_listIndexMovie.length == 1) {
                _animController!.forward();
              } else {
                if (_listIndexMovie[0] < _listIndexMovie[1]) {
                  _animController!.forward();
                } else {
                  _animController!.reverse();
                }
              }
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PageView.builder(
                              controller: _pageTextController,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: Movie.movies.length,
                              itemBuilder: (context, index) {
                                final opacity = (1 - (index - _pageText).abs())
                                    .clamp(0.0, 1.0);
                                return Opacity(
                                  opacity: opacity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Movie.movies[index].title,
                                        maxLines: 1,
                                        style: GoogleFonts.nunito(
                                            color: kPrimaryDarkColor,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        Movie.movies[index].commingDate,
                                        style: GoogleFonts.nunito(
                                            color: kPrimaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                      animation: animStar1Scale!,
                      builder: (context, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                Movie.movies[_indexMovie].ratingStars!,
                                (index) {
                              if (_listIndexMovie[0] < _listIndexMovie[1]) {
                                if (index <= _listIndexMovie[0] - 1) {
                                  return Transform.scale(
                                    scale: 1.35,
                                    child: Movie.stars[index],
                                  );
                                } else {
                                  return Transform.scale(
                                    scale: _getAnimation(index)!.value,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ),
                                  );
                                }
                              } else if (_listIndexMovie[0] >
                                  _listIndexMovie[1]) {
                                if (index <= _listIndexMovie[1] - 1) {
                                  return Transform.scale(
                                    scale: 1.35,
                                    child: Movie.stars[index],
                                  );
                                } else {
                                  return Transform.scale(
                                    scale: _getAnimation(index)!.value,
                                    child: Icon(
                                      //border
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ),
                                  );
                                }
                              } else {
                                //egalitée
                                if (index <= _listIndexMovie[1] - 1) {
                                  return Transform.scale(
                                    scale: 1.35,
                                    child: Movie.stars[index],
                                  );
                                } else {
                                  return Transform.scale(
                                    scale: _getAnimation(index)!.value,
                                    child: Icon(
                                      //border
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ),
                                  );
                                }
                              }
                            }),
                            ...List.generate(
                                5 - Movie.movies[_indexMovie].ratingStars!,
                                (index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    )),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

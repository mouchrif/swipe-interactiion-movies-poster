import 'package:flutter/material.dart';
import 'package:movie_poster/models/movie.dart';

class MovieRating extends StatefulWidget {
  final int indexMovie;
  final List<int> listIndexMovie;
  // final AnimationController animCtrl;
  // final
  MovieRating(
      {Key? key, required this.indexMovie, required this.listIndexMovie})
      : super(key: key);

  @override
  MovieRatingState createState() => MovieRatingState();
}

class MovieRatingState extends State<MovieRating>
    with SingleTickerProviderStateMixin {
  AnimationController? _animController;

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

  void forwardAndReverseAnimationStars() {
    if (widget.listIndexMovie.length == 1) {
      _animController!.forward();
    } else {
      if (widget.listIndexMovie[0] < widget.listIndexMovie[1]) {
        _animController!.forward();
      } else {
        _animController!.reverse();
      }
    }
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
      reverseCurve: Interval(0.0, 0.2, curve: Curves.ease),
    ));
    animStar2Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.ease,
      ),
      reverseCurve: Interval(0.2, 0.4, curve: Curves.ease),
    ));
    animStar3Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.ease,
      ),
      reverseCurve: Interval(0.4, 0.6, curve: Curves.ease),
    ));
    animStar4Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.ease,
      ),
      reverseCurve: Interval(0.6, 0.8, curve: Curves.ease),
    ));
    animStar5Scale =
        Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(
      parent: _animController!,
      curve: Interval(
        0.8,
        1.0,
        curve: Curves.ease,
      ),
      reverseCurve: Interval(0.8, 1.0, curve: Curves.ease),
    ));
  }

  @override
  void dispose() {
    _animController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animStar1Scale!,
        builder: (context, child) {
          return Hero(
            tag: "rating_hero",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(Movie.movies[widget.indexMovie].ratingStars!,
                    (index) {
                  if (widget.listIndexMovie[0] < widget.listIndexMovie[1]) {
                    if (index <= widget.listIndexMovie[0] - 1) {
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
                  } else if (widget.listIndexMovie[0] >
                      widget.listIndexMovie[1]) {
                    if (index <= widget.listIndexMovie[1] - 1) {
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
                    if (index <= widget.listIndexMovie[1] - 1) {
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
                    5 - Movie.movies[widget.indexMovie].ratingStars!,
                    (index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        )),
              ],
            ),
          );
        });
  }
}

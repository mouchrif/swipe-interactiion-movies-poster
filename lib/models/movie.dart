import 'package:flutter/material.dart';

import '../constants.dart';

class Movie {
  final int id;
  final String title;
  final String assetName;
  final String commingDate;
  final int? ratingStars;
  final String? description;

  Movie(
      {required this.id,
      required this.title,
      required this.assetName,
      required this.commingDate,
      this.ratingStars,
      required this.description});

  static List<Widget> stars = [
    Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20.0,
    ),
    Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20.0,
    ),
    Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20.0,
    ),
    Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20.0,
    ),
    Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20.0,
    ),
  ];

  static List<Movie> movies = [
    Movie(
      id: 1,
      title: "Sicario",
      assetName: "assets/images/poster-1.jpg",
      commingDate: "Comming in 14.06.20",
      ratingStars: 5,
      description: kParagraphMovie
    ),
    Movie(
      id: 2,
      title: "MadMax Fury Rdad",
      assetName: "assets/images/poster-2.jpg",
      commingDate: "Comming in 14.08.21",
      ratingStars: 3,
      description: kParagraphMovie
    ),
    Movie(
      id: 3,
      title: "John Wick",
      assetName: "assets/images/poster-3.jpg",
      commingDate: "Comming in 14.10.20",
      ratingStars: 5,
      description: kParagraphMovie
    ),
    Movie(
      id: 4,
      title: "Jurassic Park",
      assetName: "assets/images/poster-4.png",
      commingDate: "Comming in 14.06.20",
      ratingStars: 4,
      description: kParagraphMovie
    ),
    Movie(
      id: 5,
      title: "Dr.Strangelove",
      assetName: "assets/images/poster-5.jpg",
      commingDate: "Comming in 24.04.18",
      ratingStars: 2,
      description: kParagraphMovie
    ),
  ];
}

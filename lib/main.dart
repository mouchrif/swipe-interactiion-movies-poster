import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_poster/constants.dart';
import 'package:movie_poster/screens/display_posters.dart';
import 'package:movie_poster/screens/movie_details.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies poster',
      theme: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              brightness: Brightness.light,
            ),
        primaryColor: kPrimaryColor,
        primaryColorDark: kPrimaryDarkColor,
        primaryColorLight: kPrimaryLightColor,
        accentColor: kSecondaryColor,
      ),
      home: MyHomePage(),
      routes: {
        MovieDetails.routeName: (ctx) => MovieDetails(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.nunito(
              color: kPrimaryDarkColor,
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(
                text: "Movies",
              ),
              TextSpan(
                text: ".",
                style: GoogleFonts.nunito(
                  color: kSecondaryDarkColor,
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: DisplayPosters(),
    );
  }
}

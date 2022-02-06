import 'package:flutter/material.dart';
import 'package:marvel_logos/screens/captain_america.dart';

void main() => runApp(const MarvelLogos());

class MarvelLogos extends StatelessWidget {
  const MarvelLogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "captain",
      routes: {"captain": (context) => const CaptainAmerica()},
    );
  }
}

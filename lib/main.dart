import 'package:flutter/material.dart';
import 'package:marvel_logos/screens/captain_america.dart';
import 'package:marvel_logos/screens/iron_man.dart';

void main() => runApp(const MarvelLogos());

class MarvelLogos extends StatelessWidget {
  const MarvelLogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "iron",
      routes: {
        "captain": (context) => const CaptainAmerica(),
        "iron": (context) => const IronMan()
      },
    );
  }
}

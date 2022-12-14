import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/pages/home.dart';
import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/screenindexprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:got_app/widgets/bottonbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => ScreenIndexProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color.fromARGB(255, 23, 55, 70)),
          textTheme: GoogleFonts.bebasNeueTextTheme(),
          scaffoldBackgroundColor: Color.fromARGB(255, 23, 55, 70),
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 23, 55, 70),
          ),
        ),
        initialRoute: '/home',
        routes: {
          // When navigating to the "/" route, build the HomeScreen widget.
          '/home': (BuildContext context) {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                    ),
                    body: HomePage(),
                    bottomNavigationBar: BottomBarWidget()));
          },
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/highscores': (context) => HighScorePage(),
          '/rules': (context) => GameRulesPage(),
        });
  }
}

//Algemeen thema balken etc
// swatch maker: https://medium.com/@nickysong/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
//google fonts https://www.flutterbeads.com/google-fonts-in-flutter/
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

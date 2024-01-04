import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/screens/accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         // Provide user information
        ChangeNotifierProvider(create: (context) => LangProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Map Express',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: HexColor("#1f72a5")),
          useMaterial3: true,
        ),
        home: const ScreenSplash(),
         navigatorObservers: [MyNavigatorObserver()],
      ),
    );
  }
}

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage()),
      );
    });
    _animateIn();
  }

  void _animateIn() {
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        setState(() {
          _opacity = 1.0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1f72a5"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              curve: Curves.linearToEaseOut,
              duration: Duration(milliseconds: 500),
              opacity: _opacity,
              child: Image.asset(
                "assets/images/logo.webp",
                width: 200, // Définissez la largeur souhaitée
                height: 200, // Définissez la hauteur souhaitée
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1f72a5"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: new Center(
                child: new Text(
                  "loading.. wait...",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    
    if (previousRoute is ModalRoute && previousRoute.settings.name == '/') {
     
      return;
    }

    super.didPop(route, previousRoute);
  }
}

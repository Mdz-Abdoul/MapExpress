import 'dart:async';
import '../config/lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mapexpress/screens/accueil.dart';
import 'package:mapexpress/screens/page_M24tv.dart';
import 'package:mapexpress/screens/page_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyBottomNavigationBar extends StatefulWidget {
  final int indexG;
  const MyBottomNavigationBar({super.key, required this.indexG});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  GlobalKey _buttonKey = GlobalKey();

  String getBottomNavigationBarLabel(String lang) {
    return lang == 'fr' ? 'Accueil' : 'الرئيسية';
  }
  String getBottomNavigationBarLabel1(String lang) {
    return lang == 'fr' ? 'Recherche' : 'بحث';
  }

  @override
  void initState() {
    super.initState();
    _buttonKey = GlobalKey();
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Accueil()),
        );
      } else if (index == 1) {
        _launchURL("https://www.m24tv.ma");
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecherchePage(),
          ),
        );
      } else if (index == 3) {
        showSettingsMenu(context, _buttonKey);
      }
    });
  }

  void showSettingsMenu(BuildContext context, GlobalKey buttonKey) {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      constraints: const BoxConstraints(minWidth: 20),
      position: RelativeRect.fromLTRB(
        buttonPosition.dx + button.size.width,
        buttonPosition.dy - button.size.height - 100,
        buttonPosition.dx + 30,
        buttonPosition.dy,
      ),
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      items: [
        PopupMenuItem(
          value: 'Facebook',
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.transparent,
              child: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Twitter',
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.transparent,
              child: const Icon(
                FontAwesomeIcons.times,
                color: Colors.black,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'YouTube',
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.transparent,
              child: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
      elevation: 8,
    ).then<void>((dynamic selected) {
      if (selected != null) {
        if (selected == 'Facebook') {
          _launchURL("https://www.facebook.com/agencemarocainedepresse");
        } else if (selected == 'Twitter') {
          _launchURL("https://twitter.com/MAP_Information");
        } else if (selected == 'YouTube') {
          _launchURL("https://www.youtube.com/user/MAPTVMaroc");
        }
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir l\'URL : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String lang ='fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        key: _buttonKey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: getBottomNavigationBarLabel(lang), // Assurez-vous que lang est défini
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer_sharp),
            label: 'M24TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: getBottomNavigationBarLabel1(lang),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'Plus',
          ),
        ],
        selectedItemColor: const Color(0xFF1F72A5),
        unselectedItemColor: const Color(0xFF1F72A5),
        onTap: _onItemTapped,
      ),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VideoListPage()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

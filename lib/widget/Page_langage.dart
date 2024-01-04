import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/screens/accueil.dart';
import 'package:mapexpress/widget/appbarsecond.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbarsecond(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: 400,
            width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue, // Couleur d'arrière-plan bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 138, 137, 137), // Couleur de l'ombre
                      blurRadius: 3, // Rayon de flou de l'ombre
                    ),
                  ],
                ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Choisissez votre langue', style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1F72A5) // Background color
                      ),
                      onPressed: () {
                        Provider.of<LangProvider>(context, listen: false).setLang("fr");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Accueil()));
                      },
                      child: Text('Français', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(  
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1F72A5), // Background color
                      ),
                                    onPressed: () {
                        Provider.of<LangProvider>(context, listen: false).setLang("ar");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Accueil()));
                      },
                      child: Text('Arabe', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

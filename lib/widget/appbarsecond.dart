import 'package:flutter/material.dart';
import 'package:mapexpress/screens/accueil.dart';
import 'package:mapexpress/screens/page_search.dart';
import 'package:mapexpress/widget/Page_langage.dart';

class Sectionappbarsecond extends StatelessWidget {
  const Sectionappbarsecond();

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      backgroundColor: Color(0xFF1F72A5),
      title: InkWell(
         onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Accueil()),
                );
              },
        child: Image.asset(
          'assets/images/logo.webp', // Remplacez par le chemin de votre image
          width: 200, // Ajustez la largeur de l'image selon vos besoins
        ),
      ),
      centerTitle: true, // Pour centrer l'image
      actions: [
           IconButton(
            icon: const Icon(Icons.settings,color: Colors.white,),
            tooltip: 'Setting Icon',
            onPressed: () {
              showSettingsMenu(context);
            },
          ),
      //  ElevatedButton(
      //     onPressed: () {
      //       // Add your button's action here
      //     },
      //     style: ButtonStyle(
      //       side: MaterialStateProperty.all(
      //         BorderSide(width: 2, color: Colors.white), // Set the border width and color
      //       ),
      //       backgroundColor: MaterialStateProperty.all(Color(0xFF1F72A5),), // Make the button background transparent
      //     ),
      //     child: Text(
      //       'Français',
      //       style: TextStyle(
      //         color: Colors.white, // Set the text color
      //       ),
      //     ),
      //   ),
        // IconButton(
        //   icon: Icon(Icons.search,color: Colors.white,),
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => RecherchePage()),
        //     );
        //   },
        // ),

        // IconButton(
        //   icon:  Icon(Icons.menu),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
      ],
    );
  }
}



String lang='fr';
void showSettingsMenu(BuildContext context) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(
        overlay.localToGlobal(Offset.zero, ancestor: overlay),
        overlay.localToGlobal(
          overlay.size.bottomRight(Offset(48, 0)),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    ),
    items: [
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.language),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(lang == 'fr' ? "Langues" : 'اللغات',),
            ),
          ],
        ),
        value: 'Langues',
      ),
      // PopupMenuItem(
      //   child: Row(
      //     children: [
      //       Icon(Icons.notifications),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(lang == 'fr' ? "Notifications" : 'إشعارات',),
      //       ),
      //     ],
      //   ),
      //   value: 'Notifications',
      // ),
    ],
    elevation: 8,
  ).then<void>((dynamic selected) {
    if (selected != null) {
      if (selected == 'Langues') {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LanguageSelectionPage(),
                        ),
                      );
      } else if (selected == 'Notifications') {
        // Faites quelque chose pour l'option 2
      }
    }
  });
}
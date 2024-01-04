import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/widget/navigationBottom.dart';


class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbar(),
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 60,
            child: MyBottomNavigationBar(
              indexG: 0,
            )),
      ),
      body: ContactInfo(),
    );
  }
}

class ContactInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    String lang='fr';
     lang = Provider.of<LangProvider>(context, listen: false).language!;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                child: Row(
                  children: [
                    // const SizedBox(
                    //     width: 8.0), // Espacement entre l'icône et le texte
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/flash-fr.png"), // Remplacez par le chemin de votre image
                              // image: AssetImage('assets/images/flash-fr.webp'), // Remplacez par le chemin de votre image
                              fit: BoxFit.cover, // Ajustez selon vos besoins
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                   lang == 'fr' ? 'FLASH INFO' : 'آخر الأخبار',
                                  style: TextStyle(color: Colors.white,fontSize: 12),
                                )),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   child: Icon(
                    //     Icons.newspaper, // Icône de journal
                    //     size: 24.0,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    TextScrollerWidget(),
                    // const Spacer(), // Pour pousser TextScrollerWidget vers la droite
                    // TextScrollerWidget(monMenu: monMenu),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang == 'fr' ? "Contactez Nous" : 'اتصل بنا',
                  style: TextStyle(
                    color: Color(0xFF1F72A5),
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  lang == 'fr' ? "Adresse :" : 'عنوان',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  lang == 'fr' ? "Agence Maghreb Arabe Presse 122,Avenue Allal Ben Abdellah B.P 1049 Rabat -10000 -Maroc" : "وكالة المغرب العربي للصحافة 122 شارع علال بن عبد الله ص.ب 1049 الرباط -10000 - المغرب",
                  
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  lang == 'fr' ? "Téléphone :" : 'هاتف',
                  
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '+212 5 37 27 94 00',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  lang == 'fr' ? "E-mail :" : 'بريد إلكتروني',
                 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'com@map.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF1F72A5), // Vous pouvez également ajouter un lien vers l'e-mail
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

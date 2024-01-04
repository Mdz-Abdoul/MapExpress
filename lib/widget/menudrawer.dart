import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/screens/accueil.dart';
import 'package:mapexpress/widget/resaeaux.dart';
import 'package:mapexpress/screens/page_monde.dart';
import 'package:mapexpress/screens/page_sport.dart';
import 'package:mapexpress/screens/page_contact.dart';
import 'package:mapexpress/screens/page_culture.dart';
import 'package:mapexpress/screens/page_reglage.dart';
import 'package:mapexpress/screens/page_royales.dart';
import 'package:mapexpress/screens/page_princieres.dart';
import 'package:mapexpress/screens/page_droit_homme.dart';
import 'package:mapexpress/screens/page_grand_maghreb.dart';
import 'package:mapexpress/screens/page_opinion_debat.dart';
import 'package:mapexpress/screens/page_parlementaires.dart';
import 'package:mapexpress/screens/page_societe_civile.dart';
import 'package:mapexpress/screens/page_societe_region.dart';
import 'package:mapexpress/screens/page_gouvernementales.dart';
import 'package:mapexpress/screens/page_economie_finances.dart';
import 'package:mapexpress/screens/page_partisanes_syndicales.dart';

class CustomDrawer extends StatefulWidget {
  static const IconData sports_soccer =
      IconData(0xe5f2, fontFamily: 'MaterialIcons');
    
  const CustomDrawer({super.key});

  @override
  
  State<CustomDrawer> createState() => _CustomDrawerState();
}
  
    String lang='fr';
class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
      lang = Provider.of<LangProvider>(context).getCurrentLang();
    return Drawer(
      backgroundColor: const Color(0xFF1F72A5),
      child: ListView(
        padding: const EdgeInsets.all(25),
        children: [
        
         ListTile(
          // title: Text(lang == 'fr' ? TitreFrancais.accueil : TitreArabe.accueil,
          // style: TextStyle(fontSize: 14, color: Colors.white)),

          // title: Text(lang == 'fr' ? TitreFrancais.accueil : 'الصفحة الرئيسية',
          //   style: TextStyle(fontSize: 14, color: Colors.white)),

              title: Row(
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(lang == 'fr' ? 'Accueil' : 'الرئيسية',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Accueil()),
                );
              },
            ),

          ExpansionTile(
            title: Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(lang == 'fr' ? 'Politique' : 'سياسة',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            children: [
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Activités Royales' : 'الأنشطة الملكية',
                CustomContainerRoyalesList(),
                textColor: Colors.white,
                fontSize: 14,
                
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Activités Princières' : 'الأنشطة الأميرية',
                CustomContainerPrincieresList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Activités Parlementaires' : 'الأنشطة البرلمانية',
                
                CustomContainerParlementsList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Activités Gouvernementales' : 'الأنشطة الحكومية',
                
                CustomContainerGouvernementalesList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Activités Partisanes et Syndicales' : 'الأنشطة الحزبية و النقابية',
                
                CustomContainerPartisanesList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
            ],
          ),
          ExpansionTile(
            title: Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Société' : 'مجتمع',
                 
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            children: [
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Société et Région' : 'مجتمع وجهات',
                CustomContainerSocieteRegionList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Société Civile et vie associative' : 'المجتمع المدني والحياة المجتمعية',
                
                CustomContainerSocieteCivileList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
              _buildSubMenu(
                context,
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                lang == 'fr' ? 'Droits de l\'Homme' : 'حقوق الإنسان',
                
                CustomContainerDroitList(),
                textColor: Colors.white,
                fontSize: 14,
              ),
            ],
          ),
          ListTile(
              title: Row(
                mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(lang == 'fr' ? 'Economie et Finances' : 'الاقتصاد والمال',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomContainerEconomieList()),
                );
              },
            ),
          ListTile(
            title:  Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(lang == 'fr' ? 'Culture et Média' : 'رياضة',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomContainerCultureMediaList()),
              );
            },
          ),
          ListTile(
            title:  Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Sports' : 'الثقافة والإعلام',
                  
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomContainerSportsList()),
              );
            },
          ),
          ListTile(
            title:  Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Opinions et Débats' : 'الآراء و حوارات',
                  
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomContainerOpinionList()),
              );
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Grand Maghreb' : 'المغرب الكبير',
                  
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomContainerGrandMaghrebList()),
              );
            },
          ),
          ListTile(
            title:  Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Monde' : 'العالم',
                  
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomContainerMondesList()),
              );
            },
          ),
          ListTile(
            title:  Row(
              mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  lang == 'fr' ? 'Contactez-Nous' : 'اتصل بنا',
                  
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
          // ListTile(
          //   title:  Row(
          //     mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         lang == 'fr' ? 'Réglages' : 'إعدادات',
                  
          //           style: TextStyle(fontSize: 14, color: Colors.white)),
          //     ],
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => PageReglage()),
          //     );
          //   },
          // ),
          SizedBox(
            height: 200,
            child: SocialMediaRow(),
          )
        ],
      ),
    );
  }

  Widget _buildSubMenu(BuildContext context, String title, Widget route,
      {Color? textColor, double? fontSize, required MainAxisAlignment mainAxisAlignment}) {
    return ListTile(
      title: Row(
         mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start, 
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
    );
  }
}

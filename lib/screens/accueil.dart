import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/widget/m24tv.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:mapexpress/screens/footer.dart';
import 'package:mapexpress/widget/fakenews.dart';
import 'package:mapexpress/widget/sites_map.dart';
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/screens/page_maplive.dart';
import 'package:mapexpress/widget/section_carousel.dart';
import 'package:mapexpress/widget/activites_mondes.dart';
import 'package:mapexpress/widget/activites_sports.dart';
import 'package:mapexpress/widget/navigationBottom.dart';
import 'package:mapexpress/widget/activites_royales.dart';
import 'package:mapexpress/widget/communique_presse.dart';
import 'package:mapexpress/widget/screens/mediateur.dart';
import 'package:mapexpress/widget/activites_princieres.dart';
import 'package:mapexpress/widget/activites_droit_hommes.dart';
import 'package:mapexpress/widget/activites_culture_media.dart';
import 'package:mapexpress/widget/activites_grand_maghreb.dart';
import 'package:mapexpress/widget/activites_opinion_debat.dart';
import 'package:mapexpress/widget/activites_parlementaires.dart';
import 'package:mapexpress/widget/activites_societe_civile.dart';
import 'package:mapexpress/widget/activites_societe_region.dart';
import 'package:mapexpress/widget/activites_gouvernementales.dart';
import 'package:mapexpress/widget/activites_economie_finances.dart';
import 'package:mapexpress/widget/activites_partisanes_syndicales.dart';



class Accueil extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    String lang ='fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    return Scaffold(
      appBar: PreferredSize(preferredSize:  const Size.fromHeight(70.0),
      child: Sectionappbar(),),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 60,
            child: MyBottomNavigationBar(
              indexG: 0,
            )),
      ),
      drawer: CustomDrawer(),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Row(
                  children: [
                    // const SizedBox(
                    //     width: 8.0), // Espacement entre l'icône et le texte
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              height: 360,
              child: SectionCarousel()),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                color: Color.fromRGBO(239,  239, 239, 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 450,
                        width: double.infinity,
                        child: Card(child: CustomContainerLast()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   width: 120,
            //   height: 50,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       decoration: BoxDecoration(color: Colors.white),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Text(
            //           'Activités Royales',
            //           style: TextStyle(
            //             fontSize: 20,
            //             color: Color.fromARGB(226, 44, 161, 219),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Divider(),
            SizedBox(
              height: 470,
              // child: YourWidget(),
              child: CustomContainers(),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            SizedBox(
              height: 470,
              child: CustomContainerPrincieres(),
              // child: CustomContainerPrinciere(),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                            mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                                Text(
                                  lang == 'fr' ? "MAP LIVE" : 'خريطة حية',
                                  
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF1F72A5),
                                  ),
                                ),
                              ],
                            ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     lang == 'fr' ? "MAP LIVE" : 'خريطة حية',
                            
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       color: Color(0xFF1F72A5),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Divider(),
                SizedBox(height: 300,
                  child: MyWidgetMapLive(),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child:Row(
                            mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                                Text(
                                  lang == 'fr' ? "Communiqués de presse" : 'بيانات صحفية',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF1F72A5),
                                  ),
                                ),
                              ],
                            ),
                        //  Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     lang == 'fr' ? "Communiqués de presse" : 'بيانات صحفية',
                            
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       color: Color(0xFF1F72A5),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 350,
                    child: ActualitesPage(),
                    // child: PostContainer(
                    //   // title: "Titre du Post",
                    //   content:
                    //       "Ceci est une description de l'article.Everything related to UI, Flutter's widgets can be customized and ya obviously you can create one by your own, and that's what we are going to do today. I'll be ...",
                    //   date: "21 septembre 2023", title: '',
                    // ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                            mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                                Text(
                                 lang == 'fr' ? "Sites MAP" : 'خريطة المواقع',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF1F72A5),
                                  ),
                                ),
                              ],
                            ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     lang == 'fr' ? "Sites MAP" : 'خريطة المواقع',
                            
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       color: Color(0xFF1F72A5),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 100,
                    child: InkWell(child: ImageList()),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            
                            'M24TV',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF1F72A5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  // SizedBox(
                  //   height: 300,
                  //   width: double.infinity,
                  //   child: VideoListPage(),
                  // ),
                  SizedBox(
                    height: 380,
                    width: double.infinity,
                    child: ImageCarouselM24TV(),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 470,
            //   child: Dropmani(),
            // ),
            SizedBox(
              height: 470,
              child: CustomContainerGouvernementales(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerParlements(),
            ),
            SizedBox(
              height: 450,
              child: CustomContainerPartisanes(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerSocietes(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerEconomie(),
            ),
            SizedBox(
              height: 500,
              child: CustomContainerCultures(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerOpinions(),
            ),
            // SizedBox(
            //   height: 350,
            //   child: ImageMediateur(),
            // ),
            SizedBox(
              height: 470,
              child: CustomContainerSports(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerSocietesCiviles(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerGrandMaghreb(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerDroit(),
            ),
            SizedBox(
              height: 470,
              child: CustomContainerMondes(),
            ),
            Container(
              color: Color(0xFF1F72A5),
              child: SizedBox(
              child: PageFooter(),),
            )
            
          ],
        ),
      ),
    );
  }
}

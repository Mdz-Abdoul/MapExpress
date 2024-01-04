import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageList extends StatelessWidget {
  final List<String> imageUrls = [
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapaudio.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapphoto.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapinfo.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapinfographie.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapnews.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapnews.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapamazigh.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapecology.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/maparchives.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapnewsdisplay.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapbusiness.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapapps.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapbroadcast.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapdigital.jpg',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/logo_mapfinance.png',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/logo_mapparite.png',
    'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/maptv.jpg'
    // Ajoutez d'autres URL d'images ici
  ];
  final List<ImageData> imageDataList = [
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/maptv.jpg', // Insérez l'URL de votre première image ici
      websiteUrl: 'https://www.maptv.ma/', // Insérez l'URL de Facebook ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapaudio.jpg', // Insérez l'URL de votre première image ici
      websiteUrl: 'https://www.mapaudio.ma/', // Insérez l'URL de Facebook ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapphoto.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.mapphoto.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapinfographie.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapinfographie.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapinfo.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl:
          'https://www.mapinfo.ma/sso/login', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapnews.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.mapnews.ma/fr/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapexpress.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.mapexpress.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapamazigh.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.mapamazighe.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapecology.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapecology.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/maparchives.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.maparchives.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapnewsdisplay.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.map.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapbusiness.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://www.mapbusiness.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapapps.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl:
          'https://www.map.ma/Applications-mobiles-de-la-map/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapbroadcast.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapbroadcast.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/mapdigital.jpg', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapdigitale.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/logo_mapfinance.png', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapfinance.ma/', // Insérez l'URL de Twitter ici
    ),
    ImageData(
      imageUrl:
          'https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/logos/logo_mapparite.png', // Insérez l'URL de votre deuxième image ici
      websiteUrl: 'https://mapparite.ma/', // Insérez l'URL de Twitter ici
    ),
    // Ajoutez d'autres images et liens ici
  ];

  void _navigateToPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'URL $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imageDataList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _navigateToPage(imageDataList[index].websiteUrl);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              imageDataList[index].imageUrl,
              width: 100.0,
              height: 100.0, // Ajustez la taille de l'image selon vos besoins
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class ImageData {
  final String imageUrl;
  final String websiteUrl;

  ImageData({
    required this.imageUrl,
    required this.websiteUrl,
  });
}

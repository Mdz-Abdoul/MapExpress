import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaRow extends StatelessWidget {
  final String facebookLink = 'https://www.facebook.com';
  final String twitterLink = 'https://twitter.com';
  final String instagramLink = 'https://www.instagram.com';

  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialMediaIcon(
            'assets/images/facebook.png',
            facebookLink,
          ),
          _buildSocialMediaIcon(
            'assets/images/twitter.png',
            twitterLink,
          ),
          _buildSocialMediaIcon(
            'assets/images/youtube.png',
            instagramLink,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcon(String imagePath, String link) {
    return InkWell(
      onTap: () {
        _launchURL(link);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Image.asset(
          imagePath,
          width: 30.0,
          height: 30.0,
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }
}

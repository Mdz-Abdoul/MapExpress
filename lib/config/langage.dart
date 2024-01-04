class Lang {
  static Map<String, Map<String, String>> translations = {
    'fr': {
      'flashInfo': 'FLASH INFO',
      'shareArticle': 'Partagez cet article',
    },
    'ar': {
      'flashInfo': 'آخر الأخبار',
      'shareArticle': 'مشاركة',
    },
  };

  static String translate(String key, String lang) {
    return translations[lang]![key] ?? key;
  }
}
class Royales {
  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int featuredMedia;
  List<int> actualites;
  String formattedDate;
  String featuredImageSrc;
  String featuredImageSrcLarge;
  Links links;

  Royales({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.featuredMedia,
    required this.actualites,
    required this.formattedDate,
    required this.featuredImageSrc,
    required this.featuredImageSrcLarge,
    required this.links,
  });
}

class Content {
  String rendered;
  bool protected;

  Content({
    required this.rendered,
    required this.protected,
  });
}

class Guid {
  String rendered;

  Guid({
    required this.rendered,
  });
}

class Links {
  List<About> self;
  List<About> collection;
  List<About> about;
  List<WpFeaturedmedia> wpFeaturedmedia;
  List<About> wpAttachment;
  List<WpTerm> wpTerm;
  List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.wpFeaturedmedia,
    required this.wpAttachment,
    required this.wpTerm,
    required this.curies,
  });
}

class About {
  String href;

  About({
    required this.href,
  });
}

class Cury {
  String name;
  String href;
  bool templated;

  Cury({
    required this.name,
    required this.href,
    required this.templated,
  });
}

class WpFeaturedmedia {
  bool embeddable;
  String href;

  WpFeaturedmedia({
    required this.embeddable,
    required this.href,
  });
}

class WpTerm {
  String taxonomy;
  bool embeddable;
  String href;

  WpTerm({
    required this.taxonomy,
    required this.embeddable,
    required this.href,
  });
}

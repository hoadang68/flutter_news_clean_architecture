class News{
  String article_id;
  String title;
  String description;
  String content;
  String pubDate;
  String image_url;
  String video_url;
  List<String> category;

  News(
      {required this.article_id,
        required this.title,
        required this.description,
        required this.content,
        required this.pubDate,
        required this.image_url,
        required this.video_url,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'article_id': this.article_id,
      'title': this.title,
      'description': this.description,
      'content': this.content,
      'pubDate': this.pubDate,
      'image_url': this.image_url,
      'video_url': this.video_url,
      'category' : this.category
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      article_id: map['article_id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      content: map['content']  ?? "",
      pubDate: map['pubDate']  ?? "",
      image_url: map['image_url']  ?? "https://e7.pngegg.com/pngimages/447/851/png-clipart-white-newspaper-newspaper-newspaper-template-text.png",
      video_url: map['video_url']  ?? "",
      category: (map['category'] as List).map((item) => item as String).toList(),
    );
  }
}
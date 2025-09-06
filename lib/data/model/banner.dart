class Banner {
  int id;
  String title;
  String image;
  String createdAt;
  String updatedAt;

  Banner({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json["id"] as int,
      title: json["title"] as String,
      image:
          "http://ticktackgallery.com/media/wysiwyg/ticktackbanner/women.png",
      createdAt: json["created_at"] as String,
      updatedAt: json["updated_at"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["image"] = image;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

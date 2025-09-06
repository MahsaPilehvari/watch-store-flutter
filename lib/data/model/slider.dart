class HomeSlider {
  int id;
  String title;
  String image;

  HomeSlider({required this.id, required this.title, required this.image});

  factory HomeSlider.fromJson(Map<String, dynamic> json) {
    return HomeSlider(
      id: json["id"] as int,
      title: json["title"] as String,
      image: json["image"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image"] = image;
    data["title"] = title;
    return data;
  }
}

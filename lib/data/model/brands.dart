class Brand {
  int id;
  String title;
  String image;

  Brand({required this.id, required this.image, required this.title});

  factory Brand.fromJson(Map<String, dynamic> element) {
    return Brand(
      id: element['id'],
      image: element['image'],
      title: element['title'],
    );
  }
}

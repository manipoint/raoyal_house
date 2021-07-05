class Product {
  String? id;
  String? picture;
  String? name;
  String? description;
  bool? feature;
  double? price;
  double? rating;
  String? category;
  String? review;

  Product(this.picture, this.name, this.description, this.price, this.feature,
      this.category, this.id, this.rating, this.review);
  Product.fromJason(Map<String, dynamic> data) {
    id = data["id"];
    picture = data["picture"];
    name = data["name"];
    description = data["description"];
    feature = data["feature"];
    price = data["price"].toDouble();
    rating = data["rating"].toDouble();
    category = data["category"];
    review = data["review"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["picture"] = this.picture;
    data["name"] = this.name;
    data["description"] = this.description;
    data["feature"] = this.feature;
    data["price"] = this.price;
    data["rating"] = this.rating;
    data["category"] = this.category;
    data["review"] = this.review;
    return data;
  }
}

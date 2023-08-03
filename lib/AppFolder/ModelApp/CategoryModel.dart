class CategoryModel {
  List<dynamic>? isFavourite;
  List<dynamic>? inCart;
  String? name;
  dynamic price;
  var rate;
  String? description;
  String? delivered;
  String? productCategory;
  String? pid;


  List<String>? images;

  CategoryModel({
    this.productCategory,
    
    this.pid,
    this.rate,



    this.isFavourite,
    this.inCart,
    this.name,
    required this.price,
    this.description,
    this.delivered,
    this.images,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    images = [];
    // inCart = [];
    name = json['name'];
    rate = json['rate'];

    pid = json['pid'];

    productCategory = json['productCategory'];
    delivered = json['delivered'].toString();
    description = json['description'];
    price = json['price'];
    isFavourite = json['inFavourite'];
    inCart = json['inCart'];



    json['images'].forEach((v) {
      images!.add(v);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;

    data['pid'] = this.pid;
    data['inFavourite'] = this.isFavourite;
    data['inCart'] = this.inCart;


    data['productCategory'] = this.productCategory;
    data['price'] = this.price;
    data['description'] = this.description;
    data['images'] = this.images;

    return data;
  }
}

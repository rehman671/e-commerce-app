class AllProductResponse {
  String? message;
  int? statusCode;
  List<Product>? product;

  AllProductResponse({this.message, this.statusCode, this.product});

  AllProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.product != null) {
      data['data'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  int? catId;
  String? title;
  String? unit;
  int? stockAvailable;
  String? image;
  String? color;
  double? price;
  int? qty;
  int favproduct = 1;
  bool Addtocart = false;


  Product(
      {this.id,
        this.catId,
        this.title,
        this.unit,
        this.stockAvailable,
        this.image,
        this.color,
        this.price,
        this.qty});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['catId'];
    title = json['title'];
    unit = json['unit'];
    stockAvailable = json['stockAvailable'];
    image = json['image'];
    color = json['color'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catId'] = this.catId;
    data['title'] = this.title;
    data['unit'] = this.unit;
    data['stockAvailable'] = this.stockAvailable;
    data['image'] = this.image;
    data['color'] = this.color;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}

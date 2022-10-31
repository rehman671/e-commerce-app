

class OrderResponse {
  String? message;
  int? statusCode;
  Order? order;

  OrderResponse({this.message, this.statusCode, this.order});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    order = json['data'] != null ? new Order.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.order != null) {
      data['data'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? zip;
  String? city;
  String? country;
  Customer? customer;
  List<Items>? items;

  Order(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.address,
        this.zip,
        this.city,
        this.country,
        this.customer,
        this.items});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? email;
  String? phone;
  String? password;
  String? accessToken;

  Customer({this.id, this.email, this.phone, this.password, this.accessToken});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['accessToken'] = this.accessToken;
    return data;
  }
}

class Items {
  int? id;
  int? catId;
  String? title;
  String? unit;
  int? stockAvailable;
  String? image;
  String? color;
  double? price;
  Null? qty;

  Items(
      {this.id,
        this.catId,
        this.title,
        this.unit,
        this.stockAvailable,
        this.image,
        this.color,
        this.price,
        this.qty});

  Items.fromJson(Map<String, dynamic> json) {
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

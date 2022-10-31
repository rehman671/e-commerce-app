class Users {
  String? message;
  int? statusCode;
  List<UserItems>? useritems;

  Users({this.message, this.statusCode, this.useritems});

  Users.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      useritems = <UserItems>[];
      json['data'].forEach((v) {
        useritems!.add(new UserItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(String encodedjson) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.useritems != null) {
      data['data'] = this.useritems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserItems {
  int? id;
  String? email;
  String? phone;
  String? password;
  String? accessToken;

  UserItems({this.id, this.email, this.phone, this.password, this.accessToken});

  UserItems.fromJson(Map<String, dynamic> json) {
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

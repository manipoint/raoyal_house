import 'package:raoyal_house/models/cart.dart';

class UserModel {
  String? gender;
  Name? name;
  LocationModel? location;
  String? email;
  String? phone;
  String? id;
  Picture? picture;
  List<CartModel>? cart;

  UserModel(
      {this.gender,
      this.name,
      this.location,
      this.email,
      this.phone,
      this.id,
      this.picture,
      this.cart});

  UserModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
    email = json['email'];

    phone = json['phone'];

    id = json['id'];
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    cart = _convertCartItems(json["cart"] ?? []);
  } 
  List<CartModel> _convertCartItems(List cartFomDb) {
    List<CartModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['phone'] = this.phone;

    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }

    return data;
  }
}

class Name {
  String? title;
  String? first;
  String? last;

  Name({this.title, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}

class LocationModel {
  String? street;
  String? city;
  String? state;
  String? postcode;
  Coordinates? coordinates;

  LocationModel({
    this.street,
    this.city,
    this.state,
    this.postcode,
    this.coordinates,
  });

  LocationModel.fromJson(Map<String?, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'].toString();
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }

    return data;
  }
}

class Coordinates {
  String? latitude;
  String? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  Picture.fromJson(Map<String?, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

















// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'cart.dart';

// class UserModel {
//   static const ID = "id";
//   static const NAME = "name";
//   static const EMAIL = "email";
//   static const PHONE = "phone";
//   static const CART = "cart";

//   String?? id;
//   String?? name;
//   String?? email;
//   String?? phone;


//   List<LocationModel>? location;
//   List<CartModel>? cart;

//   UserModel(
//       {this.id, this.name, this.email, this.phone, this.cart, this.location});

//   UserModel.fromSnapshot(DocumentSnapshot<Map<String?, dynamic>> snapshot) {
//     id = snapshot.data()?[ID];
//     name = snapshot.data()?[NAME];
//     email = snapshot.data()?[EMAIL];
//     phone = snapshot.data()?[PHONE];
//     cart = _convertCartItems(snapshot.data()![CART] ?? []);
//     location = _convertLocation(snapshot.data()!["location"] ?? []);
//   }

//   List<CartModel> _convertCartItems(List cartFomDb) {
//     List<CartModel> _result = [];
//     if (cartFomDb.length > 0) {
//       cartFomDb.forEach((element) {
//         _result.add(CartModel.fromMap(element));
//       });
//     }
//     return _result;
//   }

//   List<LocationModel> _convertLocation(List locationFomDb) {
//     List<LocationModel> _result = [];
//     if (locationFomDb.length > 0) {
//       locationFomDb.forEach((element) {
//         _result.add(LocationModel.fromJson(element));
//       });
//     }
//     return _result;
//   }

//   List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
// }

// class LocationModel {
//   String?? street;
//   String?? city;
//   String?? state;
//   String?? postcode;
//   // Coordinates? coordinates;

//   LocationModel({
//     this.street,
//     this.city,
//     this.state,
//     this.postcode,
//     // this.coordinates,
//   });

//   LocationModel.fromJson(Map<String?, dynamic> json) {
//     street = json['street'];
//     city = json['city'];
//     state = json['state'];
//     postcode = json['postcode'].toString?();
//     // coordinates = json['coordinates'] != null
//     //     ? new Coordinates.fromJson(json['coordinates'])
//     //     : null;
//   }

//   Map<String?, dynamic> toJson() {
//     final Map<String?, dynamic> data = new Map<String?, dynamic>();
//     data['street'] = this.street;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['postcode'] = this.postcode;
//     // if (this.coordinates != null) {
//     //   data['coordinates'] = this.coordinates!.toJson();
//      //}
//     return data;
//   }
// }

// class Coordinates {
//   String?? latitude;
//   String?? longitude;

//   Coordinates({this.latitude, this.longitude});

//   Coordinates.fromJson(Map<String?, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String?, dynamic> toJson() {
//     final Map<String?, dynamic> data = new Map<String?, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }

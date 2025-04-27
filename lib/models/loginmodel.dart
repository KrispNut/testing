class LoginModel {
  String? errorMessage;
  String? message;
  bool? success;
  Data? data;
  int? status;

  LoginModel(
      {this.errorMessage, this.message, this.success, this.data, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    message = json['Message'];
    success = json['Success'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Message'] = this.message;
    data['Success'] = this.success;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? customerId;
  String? name;
  String? gender;
  String? dateBirth;
  String? email;
  String? cellNum;
  int? emailVerified;
  String? token;
  String? restaurantName;
  List<Addresses>? addresses;

  Data(
      {this.id,
        this.customerId,
        this.name,
        this.gender,
        this.dateBirth,
        this.email,
        this.cellNum,
        this.emailVerified,
        this.token,
        this.restaurantName,
        this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    gender = json['gender'];
    dateBirth = json['date_birth'];
    email = json['email'];
    cellNum = json['cell_num'];
    emailVerified = json['email_verified'];
    token = json['token'];
    restaurantName = json['restaurant_name'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['date_birth'] = this.dateBirth;
    data['email'] = this.email;
    data['cell_num'] = this.cellNum;
    data['email_verified'] = this.emailVerified;
    data['token'] = this.token;
    data['restaurant_name'] = this.restaurantName;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  String? customerId;
  int? customerIdd;
  String? addressId;
  int? addressTypeId;
  String? addressType;
  String? address1;
  String? latitude;
  String? longitude;
  int? isDefault;

  Addresses(
      {this.id,
        this.customerId,
        this.customerIdd,
        this.addressId,
        this.addressTypeId,
        this.addressType,
        this.address1,
        this.latitude,
        this.longitude,
        this.isDefault});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerIdd = json['customer_idd'];
    addressId = json['address_id'];
    addressTypeId = json['address_type_id'];
    addressType = json['address_type'];
    address1 = json['address1'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['customer_idd'] = this.customerIdd;
    data['address_id'] = this.addressId;
    data['address_type_id'] = this.addressTypeId;
    data['address_type'] = this.addressType;
    data['address1'] = this.address1;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class FetchModel {
  FetchModel({
    required this.errorMessage,
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  final String? errorMessage;
  final String? message;
  final bool? success;
  final Data? data;
  final int? status;

  factory FetchModel.fromJson(Map<String, dynamic> json) {
    return FetchModel(
      errorMessage: json["ErrorMessage"],
      message: json["Message"],
      success: json["Success"],
      data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      status: json["Status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ErrorMessage": errorMessage,
        "Message": message,
        "Success": success,
        "Data": data?.toJson(),
        "Status": status,
      };
}

class Data {
  Data({
    required this.id,
    required this.restaurantBranchId,
    required this.name,
    required this.address,
    required this.isDelivery,
    required this.isDinein,
    required this.isFreedelivery,
    required this.isTakeaway,
    required this.taxInclude,
    required this.taxPercent,
    required this.logo,
    required this.logoUrl,
    required this.latitude,
    required this.longitude,
    required this.townId,
    required this.minimumOrderValue,
    required this.mobileNumber,
    required this.mobileNumber2,
    required this.mobileNumber3,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.phoneNumber3,
    required this.contactEmail,
    required this.deliveryFee,
    required this.serviceFee,
    required this.onlineDiscountPercent,
    required this.currency,
    required this.openTime,
    required this.closeTime,
    required this.isOrderByTown,
    required this.facebookProfileUrl,
    required this.instagramProfileUrl,
    required this.youtubeProfileUrl,
    required this.tiktokProfileUrl,
    required this.xProfileUrl,
    required this.linkedinProfileUrl,
    required this.androidAppUrl,
    required this.iosAppUrl,
    required this.restaurantBranchMenu,
    required this.banners,
  });

  final int? id;
  final String? restaurantBranchId;
  final String? name;
  final String? address;
  final bool? isDelivery;
  final bool? isDinein;
  final bool? isFreedelivery;
  final int? isTakeaway;
  final bool? taxInclude;
  final String? taxPercent;
  final dynamic logo;
  final String? logoUrl;
  final String? latitude;
  final String? longitude;
  final int? townId;
  final int? minimumOrderValue;
  final dynamic mobileNumber;
  final dynamic mobileNumber2;
  final dynamic mobileNumber3;
  final String? phoneNumber;
  final dynamic phoneNumber2;
  final dynamic phoneNumber3;
  final String? contactEmail;
  final String? deliveryFee;
  final String? serviceFee;
  final int? onlineDiscountPercent;
  final String? currency;
  final String? openTime;
  final String? closeTime;
  final int? isOrderByTown;
  final String? facebookProfileUrl;
  final String? instagramProfileUrl;
  final String? youtubeProfileUrl;
  final String? tiktokProfileUrl;
  final String? xProfileUrl;
  final String? linkedinProfileUrl;
  final String? androidAppUrl;
  final String? iosAppUrl;
  final List<dynamic> restaurantBranchMenu;
  final List<dynamic> banners;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      restaurantBranchId: json["restaurant_branch_id"],
      name: json["name"],
      address: json["address"],
      isDelivery: json["is_delivery"],
      isDinein: json["is_dinein"],
      isFreedelivery: json["is_freedelivery"],
      isTakeaway: json["is_takeaway"],
      taxInclude: json["tax_include"],
      taxPercent: json["tax_percent"],
      logo: json["logo"],
      logoUrl: json["logo_url"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      townId: json["town_id"],
      minimumOrderValue: json["minimum_order_value"],
      mobileNumber: json["mobile_number"],
      mobileNumber2: json["mobile_number2"],
      mobileNumber3: json["mobile_number3"],
      phoneNumber: json["phone_number"],
      phoneNumber2: json["phone_number2"],
      phoneNumber3: json["phone_number3"],
      contactEmail: json["contact_email"],
      deliveryFee: json["delivery_fee"],
      serviceFee: json["service_fee"],
      onlineDiscountPercent: json["online_discount_percent"],
      currency: json["currency"],
      openTime: json["open_time"],
      closeTime: json["close_time"],
      isOrderByTown: json["is_order_by_town"],
      facebookProfileUrl: json["facebook_profile_url"],
      instagramProfileUrl: json["instagram_profile_url"],
      youtubeProfileUrl: json["youtube_profile_url"],
      tiktokProfileUrl: json["tiktok_profile_url"],
      xProfileUrl: json["x_profile_url"],
      linkedinProfileUrl: json["linkedin_profile_url"],
      androidAppUrl: json["android_app_url"],
      iosAppUrl: json["ios_app_url"],
      restaurantBranchMenu: json["restaurant_branch_menu"] == null
          ? []
          : List<dynamic>.from(json["restaurant_branch_menu"]!.map((x) => x)),
      banners: json["banners"] == null
          ? []
          : List<dynamic>.from(json["banners"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_branch_id": restaurantBranchId,
        "name": name,
        "address": address,
        "is_delivery": isDelivery,
        "is_dinein": isDinein,
        "is_freedelivery": isFreedelivery,
        "is_takeaway": isTakeaway,
        "tax_include": taxInclude,
        "tax_percent": taxPercent,
        "logo": logo,
        "logo_url": logoUrl,
        "latitude": latitude,
        "longitude": longitude,
        "town_id": townId,
        "minimum_order_value": minimumOrderValue,
        "mobile_number": mobileNumber,
        "mobile_number2": mobileNumber2,
        "mobile_number3": mobileNumber3,
        "phone_number": phoneNumber,
        "phone_number2": phoneNumber2,
        "phone_number3": phoneNumber3,
        "contact_email": contactEmail,
        "delivery_fee": deliveryFee,
        "service_fee": serviceFee,
        "online_discount_percent": onlineDiscountPercent,
        "currency": currency,
        "open_time": openTime,
        "close_time": closeTime,
        "is_order_by_town": isOrderByTown,
        "facebook_profile_url": facebookProfileUrl,
        "instagram_profile_url": instagramProfileUrl,
        "youtube_profile_url": youtubeProfileUrl,
        "tiktok_profile_url": tiktokProfileUrl,
        "x_profile_url": xProfileUrl,
        "linkedin_profile_url": linkedinProfileUrl,
        "android_app_url": androidAppUrl,
        "ios_app_url": iosAppUrl,
        "restaurant_branch_menu": restaurantBranchMenu.map((x) => x).toList(),
        "banners": banners.map((x) => x).toList(),
      };
}

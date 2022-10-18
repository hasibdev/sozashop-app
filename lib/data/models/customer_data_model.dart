import 'dart:convert';

class CustomerDataModel {
  CustomerDataModel({
    this.city,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.country,
    this.website,
    this.invoiceFooter,
    this.defaultCustomer,
  });

  final dynamic city;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic address;
  final String? country;
  final String? website;
  final String? invoiceFooter;
  final int? defaultCustomer;

  CustomerDataModel copyWith({
    dynamic city,
    String? name,
    String? email,
    String? phone,
    dynamic address,
    String? country,
    String? website,
    String? invoiceFooter,
    int? defaultCustomer,
  }) =>
      CustomerDataModel(
        city: city ?? this.city,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        country: country ?? this.country,
        website: website ?? this.website,
        invoiceFooter: invoiceFooter ?? this.invoiceFooter,
        defaultCustomer: defaultCustomer ?? this.defaultCustomer,
      );

  factory CustomerDataModel.fromRawJson(String str) =>
      CustomerDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) =>
      CustomerDataModel(
        city: json["city"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        website: json["website"],
        invoiceFooter: json["invoiceFooter"],
        defaultCustomer: json["defaultCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "country": country,
        "website": website,
        "invoiceFooter": invoiceFooter,
        "defaultCustomer": defaultCustomer,
      };
}

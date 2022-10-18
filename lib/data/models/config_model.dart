import 'dart:convert';

class Config {
  Config({
    required this.enums,
    required this.options,
    required this.settings,
  });

  final Enums enums;
  final Map<String, List<OptionModel>> options;
  final List<Setting> settings;

  Config copyWith({
    Enums? enums,
    Map<String, List<OptionModel>>? options,
    List<Setting>? settings,
  }) =>
      Config(
        enums: enums ?? this.enums,
        options: options ?? this.options,
        settings: settings ?? this.settings,
      );

  factory Config.fromRawJson(String str) => Config.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        enums: Enums.fromJson(json["enums"]),
        options: Map.from(json["options"]).map((k, v) =>
            MapEntry<String, List<OptionModel>>(k,
                List<OptionModel>.from(v.map((x) => OptionModel.fromJson(x))))),
        settings: List<Setting>.from(
            json["settings"].map((x) => Setting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "enums": enums.toJson(),
        "options": Map.from(options).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "settings": List<dynamic>.from(settings.map((x) => x.toJson())),
      };
}

class Enums {
  Enums({
    required this.activeStatus,
    required this.notificationType,
    required this.settingType,
    required this.invoiceStatus,
    required this.paymentMethod,
    required this.paymentable,
    required this.loanType,
    required this.discountType,
    required this.chargeType,
    required this.chargedBy,
    required this.accountType,
    required this.serviceType,
    required this.openStatus,
    required this.priority,
  });

  final ActiveStatus activeStatus;
  final NotificationType notificationType;
  final SettingType settingType;
  final InvoiceStatus invoiceStatus;
  final PaymentMethod paymentMethod;
  final Paymentable paymentable;
  final LoanType loanType;
  final Type discountType;
  final Type chargeType;
  final ChargedBy chargedBy;
  final AccountType accountType;
  final ServiceType serviceType;
  final OpenStatus openStatus;
  final Priority priority;

  Enums copyWith({
    ActiveStatus? activeStatus,
    NotificationType? notificationType,
    SettingType? settingType,
    InvoiceStatus? invoiceStatus,
    PaymentMethod? paymentMethod,
    Paymentable? paymentable,
    LoanType? loanType,
    Type? discountType,
    Type? chargeType,
    ChargedBy? chargedBy,
    AccountType? accountType,
    ServiceType? serviceType,
    OpenStatus? openStatus,
    Priority? priority,
  }) =>
      Enums(
        activeStatus: activeStatus ?? this.activeStatus,
        notificationType: notificationType ?? this.notificationType,
        settingType: settingType ?? this.settingType,
        invoiceStatus: invoiceStatus ?? this.invoiceStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentable: paymentable ?? this.paymentable,
        loanType: loanType ?? this.loanType,
        discountType: discountType ?? this.discountType,
        chargeType: chargeType ?? this.chargeType,
        chargedBy: chargedBy ?? this.chargedBy,
        accountType: accountType ?? this.accountType,
        serviceType: serviceType ?? this.serviceType,
        openStatus: openStatus ?? this.openStatus,
        priority: priority ?? this.priority,
      );

  factory Enums.fromRawJson(String str) => Enums.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Enums.fromJson(Map<String, dynamic> json) => Enums(
        activeStatus: ActiveStatus.fromJson(json["activeStatus"]),
        notificationType: NotificationType.fromJson(json["notificationType"]),
        settingType: SettingType.fromJson(json["settingType"]),
        invoiceStatus: InvoiceStatus.fromJson(json["invoiceStatus"]),
        paymentMethod: PaymentMethod.fromJson(json["paymentMethod"]),
        paymentable: Paymentable.fromJson(json["paymentable"]),
        loanType: LoanType.fromJson(json["loanType"]),
        discountType: Type.fromJson(json["discountType"]),
        chargeType: Type.fromJson(json["chargeType"]),
        chargedBy: ChargedBy.fromJson(json["chargedBy"]),
        accountType: AccountType.fromJson(json["accountType"]),
        serviceType: ServiceType.fromJson(json["serviceType"]),
        openStatus: OpenStatus.fromJson(json["openStatus"]),
        priority: Priority.fromJson(json["priority"]),
      );

  Map<String, dynamic> toJson() => {
        "activeStatus": activeStatus.toJson(),
        "notificationType": notificationType.toJson(),
        "settingType": settingType.toJson(),
        "invoiceStatus": invoiceStatus.toJson(),
        "paymentMethod": paymentMethod.toJson(),
        "paymentable": paymentable.toJson(),
        "loanType": loanType.toJson(),
        "discountType": discountType.toJson(),
        "chargeType": chargeType.toJson(),
        "chargedBy": chargedBy.toJson(),
        "accountType": accountType.toJson(),
        "serviceType": serviceType.toJson(),
        "openStatus": openStatus.toJson(),
        "priority": priority.toJson(),
      };
}

class AccountType {
  AccountType({
    required this.bank,
    required this.mobileBanking,
  });

  final String bank;
  final String mobileBanking;

  AccountType copyWith({
    String? bank,
    String? mobileBanking,
  }) =>
      AccountType(
        bank: bank ?? this.bank,
        mobileBanking: mobileBanking ?? this.mobileBanking,
      );

  factory AccountType.fromRawJson(String str) =>
      AccountType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountType.fromJson(Map<String, dynamic> json) => AccountType(
        bank: json["BANK"],
        mobileBanking: json["MOBILE_BANKING"],
      );

  Map<String, dynamic> toJson() => {
        "BANK": bank,
        "MOBILE_BANKING": mobileBanking,
      };
}

class ActiveStatus {
  ActiveStatus({
    required this.inactive,
    required this.active,
  });

  final String inactive;
  final String active;

  ActiveStatus copyWith({
    String? inactive,
    String? active,
  }) =>
      ActiveStatus(
        inactive: inactive ?? this.inactive,
        active: active ?? this.active,
      );

  factory ActiveStatus.fromRawJson(String str) =>
      ActiveStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActiveStatus.fromJson(Map<String, dynamic> json) => ActiveStatus(
        inactive: json["INACTIVE"],
        active: json["ACTIVE"],
      );

  Map<String, dynamic> toJson() => {
        "INACTIVE": inactive,
        "ACTIVE": active,
      };
}

class Type {
  Type({
    required this.fixed,
    required this.percentage,
  });

  final String fixed;
  final String percentage;

  Type copyWith({
    String? fixed,
    String? percentage,
  }) =>
      Type(
        fixed: fixed ?? this.fixed,
        percentage: percentage ?? this.percentage,
      );

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        fixed: json["FIXED"],
        percentage: json["PERCENTAGE"],
      );

  Map<String, dynamic> toJson() => {
        "FIXED": fixed,
        "PERCENTAGE": percentage,
      };
}

class ChargedBy {
  ChargedBy({
    required this.government,
    required this.company,
  });

  final String government;
  final String company;

  ChargedBy copyWith({
    String? government,
    String? company,
  }) =>
      ChargedBy(
        government: government ?? this.government,
        company: company ?? this.company,
      );

  factory ChargedBy.fromRawJson(String str) =>
      ChargedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargedBy.fromJson(Map<String, dynamic> json) => ChargedBy(
        government: json["GOVERNMENT"],
        company: json["COMPANY"],
      );

  Map<String, dynamic> toJson() => {
        "GOVERNMENT": government,
        "COMPANY": company,
      };
}

class InvoiceStatus {
  InvoiceStatus({
    required this.draft,
    required this.confirmed,
    required this.partial,
    required this.paid,
  });

  final String draft;
  final String confirmed;
  final String partial;
  final String paid;

  InvoiceStatus copyWith({
    String? draft,
    String? confirmed,
    String? partial,
    String? paid,
  }) =>
      InvoiceStatus(
        draft: draft ?? this.draft,
        confirmed: confirmed ?? this.confirmed,
        partial: partial ?? this.partial,
        paid: paid ?? this.paid,
      );

  factory InvoiceStatus.fromRawJson(String str) =>
      InvoiceStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceStatus.fromJson(Map<String, dynamic> json) => InvoiceStatus(
        draft: json["DRAFT"],
        confirmed: json["CONFIRMED"],
        partial: json["PARTIAL"],
        paid: json["PAID"],
      );

  Map<String, dynamic> toJson() => {
        "DRAFT": draft,
        "CONFIRMED": confirmed,
        "PARTIAL": partial,
        "PAID": paid,
      };
}

class LoanType {
  LoanType({
    required this.given,
    required this.taken,
  });

  final String given;
  final String taken;

  LoanType copyWith({
    String? given,
    String? taken,
  }) =>
      LoanType(
        given: given ?? this.given,
        taken: taken ?? this.taken,
      );

  factory LoanType.fromRawJson(String str) =>
      LoanType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoanType.fromJson(Map<String, dynamic> json) => LoanType(
        given: json["GIVEN"],
        taken: json["TAKEN"],
      );

  Map<String, dynamic> toJson() => {
        "GIVEN": given,
        "TAKEN": taken,
      };
}

class NotificationType {
  NotificationType({
    required this.info,
    required this.warning,
    required this.success,
    required this.danger,
  });

  final String info;
  final String warning;
  final String success;
  final String danger;

  NotificationType copyWith({
    String? info,
    String? warning,
    String? success,
    String? danger,
  }) =>
      NotificationType(
        info: info ?? this.info,
        warning: warning ?? this.warning,
        success: success ?? this.success,
        danger: danger ?? this.danger,
      );

  factory NotificationType.fromRawJson(String str) =>
      NotificationType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationType.fromJson(Map<String, dynamic> json) =>
      NotificationType(
        info: json["INFO"],
        warning: json["WARNING"],
        success: json["SUCCESS"],
        danger: json["DANGER"],
      );

  Map<String, dynamic> toJson() => {
        "INFO": info,
        "WARNING": warning,
        "SUCCESS": success,
        "DANGER": danger,
      };
}

class OpenStatus {
  OpenStatus({
    required this.open,
    required this.close,
  });

  final String open;
  final String close;

  OpenStatus copyWith({
    String? open,
    String? close,
  }) =>
      OpenStatus(
        open: open ?? this.open,
        close: close ?? this.close,
      );

  factory OpenStatus.fromRawJson(String str) =>
      OpenStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpenStatus.fromJson(Map<String, dynamic> json) => OpenStatus(
        open: json["OPEN"],
        close: json["CLOSE"],
      );

  Map<String, dynamic> toJson() => {
        "OPEN": open,
        "CLOSE": close,
      };
}

class PaymentMethod {
  PaymentMethod({
    required this.cash,
    required this.bank,
  });

  final String cash;
  final String bank;

  PaymentMethod copyWith({
    String? cash,
    String? bank,
  }) =>
      PaymentMethod(
        cash: cash ?? this.cash,
        bank: bank ?? this.bank,
      );

  factory PaymentMethod.fromRawJson(String str) =>
      PaymentMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        cash: json["CASH"],
        bank: json["BANK"],
      );

  Map<String, dynamic> toJson() => {
        "CASH": cash,
        "BANK": bank,
      };
}

class Paymentable {
  Paymentable({
    required this.loan,
    required this.saleInvoice,
    required this.returnInvoice,
    required this.expenseInvoice,
    required this.purchaseInvoice,
  });

  final String loan;
  final String saleInvoice;
  final String returnInvoice;
  final String expenseInvoice;
  final String purchaseInvoice;

  Paymentable copyWith({
    String? loan,
    String? saleInvoice,
    String? returnInvoice,
    String? expenseInvoice,
    String? purchaseInvoice,
  }) =>
      Paymentable(
        loan: loan ?? this.loan,
        saleInvoice: saleInvoice ?? this.saleInvoice,
        returnInvoice: returnInvoice ?? this.returnInvoice,
        expenseInvoice: expenseInvoice ?? this.expenseInvoice,
        purchaseInvoice: purchaseInvoice ?? this.purchaseInvoice,
      );

  factory Paymentable.fromRawJson(String str) =>
      Paymentable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paymentable.fromJson(Map<String, dynamic> json) => Paymentable(
        loan: json["LOAN"],
        saleInvoice: json["SALE_INVOICE"],
        returnInvoice: json["RETURN_INVOICE"],
        expenseInvoice: json["EXPENSE_INVOICE"],
        purchaseInvoice: json["PURCHASE_INVOICE"],
      );

  Map<String, dynamic> toJson() => {
        "LOAN": loan,
        "SALE_INVOICE": saleInvoice,
        "RETURN_INVOICE": returnInvoice,
        "EXPENSE_INVOICE": expenseInvoice,
        "PURCHASE_INVOICE": purchaseInvoice,
      };
}

class Priority {
  Priority({
    required this.high,
    required this.medium,
    required this.low,
  });

  final String high;
  final String medium;
  final String low;

  Priority copyWith({
    String? high,
    String? medium,
    String? low,
  }) =>
      Priority(
        high: high ?? this.high,
        medium: medium ?? this.medium,
        low: low ?? this.low,
      );

  factory Priority.fromRawJson(String str) =>
      Priority.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        high: json["HIGH"],
        medium: json["MEDIUM"],
        low: json["LOW"],
      );

  Map<String, dynamic> toJson() => {
        "HIGH": high,
        "MEDIUM": medium,
        "LOW": low,
      };
}

class ServiceType {
  ServiceType({
    required this.weekly,
    required this.bimontyly,
    required this.monthly,
    required this.yearly,
    required this.onetime,
  });

  final String weekly;
  final String bimontyly;
  final String monthly;
  final String yearly;
  final String onetime;

  ServiceType copyWith({
    String? weekly,
    String? bimontyly,
    String? monthly,
    String? yearly,
    String? onetime,
  }) =>
      ServiceType(
        weekly: weekly ?? this.weekly,
        bimontyly: bimontyly ?? this.bimontyly,
        monthly: monthly ?? this.monthly,
        yearly: yearly ?? this.yearly,
        onetime: onetime ?? this.onetime,
      );

  factory ServiceType.fromRawJson(String str) =>
      ServiceType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        weekly: json["WEEKLY"],
        bimontyly: json["BIMONTYLY"],
        monthly: json["MONTHLY"],
        yearly: json["YEARLY"],
        onetime: json["ONETIME"],
      );

  Map<String, dynamic> toJson() => {
        "WEEKLY": weekly,
        "BIMONTYLY": bimontyly,
        "MONTHLY": monthly,
        "YEARLY": yearly,
        "ONETIME": onetime,
      };
}

class SettingType {
  SettingType({
    required this.application,
    required this.currency,
    required this.payment,
  });

  final String application;
  final String currency;
  final String payment;

  SettingType copyWith({
    String? application,
    String? currency,
    String? payment,
  }) =>
      SettingType(
        application: application ?? this.application,
        currency: currency ?? this.currency,
        payment: payment ?? this.payment,
      );

  factory SettingType.fromRawJson(String str) =>
      SettingType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingType.fromJson(Map<String, dynamic> json) => SettingType(
        application: json["APPLICATION"],
        currency: json["CURRENCY"],
        payment: json["PAYMENT"],
      );

  Map<String, dynamic> toJson() => {
        "APPLICATION": application,
        "CURRENCY": currency,
        "PAYMENT": payment,
      };
}

class OptionModel {
  OptionModel({
    required this.value,
    required this.name,
  });

  final String value;
  final String name;

  OptionModel copyWith({
    String? value,
    String? name,
  }) =>
      OptionModel(
        value: value ?? this.value,
        name: name ?? this.name,
      );

  factory OptionModel.fromRawJson(String str) =>
      OptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        value: json["value"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };
}

class Setting {
  Setting({
    required this.id,
    required this.clientId,
    required this.type,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.customer,
    required this.primaryMediaUrl,
    required this.media,
  });

  final int id;
  final int clientId;
  final String type;
  final Data data;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Customer? customer;
  final String primaryMediaUrl;
  final List<Media> media;

  Setting copyWith({
    int? id,
    int? clientId,
    String? type,
    Data? data,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    Customer? customer,
    String? primaryMediaUrl,
    List<Media>? media,
  }) =>
      Setting(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        type: type ?? this.type,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        customer: customer ?? this.customer,
        primaryMediaUrl: primaryMediaUrl ?? this.primaryMediaUrl,
        media: media ?? this.media,
      );

  factory Setting.fromRawJson(String str) => Setting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        clientId: json["clientId"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        primaryMediaUrl: json["primaryMediaUrl"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "type": type,
        "data": data.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "customer": customer == null ? null : customer?.toJson(),
        "primaryMediaUrl": primaryMediaUrl,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}

class Customer {
  Customer({
    required this.id,
    required this.clientId,
    required this.name,
    required this.mobile,
    required this.password,
    required this.email,
    required this.address,
    required this.openingBalance,
    required this.totalAmount,
    required this.paidAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.totalDue,
    required this.clientName,
    required this.shopName,
  });

  final int id;
  final int clientId;
  final String name;
  final dynamic mobile;
  final dynamic password;
  final dynamic email;
  final dynamic address;
  final int openingBalance;
  final double totalAmount;
  final int paidAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final double totalDue;
  final String clientName;
  final String shopName;

  Customer copyWith({
    int? id,
    int? clientId,
    String? name,
    dynamic mobile,
    dynamic password,
    dynamic email,
    dynamic address,
    int? openingBalance,
    double? totalAmount,
    int? paidAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    double? totalDue,
    String? clientName,
    String? shopName,
  }) =>
      Customer(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        password: password ?? this.password,
        email: email ?? this.email,
        address: address ?? this.address,
        openingBalance: openingBalance ?? this.openingBalance,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        totalDue: totalDue ?? this.totalDue,
        clientName: clientName ?? this.clientName,
        shopName: shopName ?? this.shopName,
      );

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        mobile: json["mobile"],
        password: json["password"],
        email: json["email"],
        address: json["address"],
        openingBalance: json["openingBalance"],
        totalAmount: json["totalAmount"].toDouble(),
        paidAmount: json["paidAmount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        totalDue: json["totalDue"].toDouble(),
        clientName: json["clientName"],
        shopName: json["shopName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "mobile": mobile,
        "password": password,
        "email": email,
        "address": address,
        "openingBalance": openingBalance,
        "totalAmount": totalAmount,
        "paidAmount": paidAmount,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "totalDue": totalDue,
        "clientName": clientName,
        "shopName": shopName,
      };
}

class Data {
  Data({
    this.city,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.country,
    this.website,
    this.invoiceFooter,
    this.defaultCustomer,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
  });

  final String? city;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? country;
  final String? website;
  final String? invoiceFooter;
  final int? defaultCustomer;
  final String? currencyCode;
  final String? currencyName;
  final String? currencySymbol;

  Data copyWith({
    String? city,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? country,
    String? website,
    String? invoiceFooter,
    int? defaultCustomer,
    String? currencyCode,
    String? currencyName,
    String? currencySymbol,
  }) =>
      Data(
        city: city ?? this.city,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        country: country ?? this.country,
        website: website ?? this.website,
        invoiceFooter: invoiceFooter ?? this.invoiceFooter,
        defaultCustomer: defaultCustomer ?? this.defaultCustomer,
        currencyCode: currencyCode ?? this.currencyCode,
        currencyName: currencyName ?? this.currencyName,
        currencySymbol: currencySymbol ?? this.currencySymbol,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        city: json["city"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        website: json["website"],
        invoiceFooter: json["invoiceFooter"],
        defaultCustomer: json["defaultCustomer"],
        currencyCode: json["currency_code"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
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
        "currency_code": currencyCode,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
      };
}

class Media {
  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.conversionsDisk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final List<dynamic> generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final DateTime createdAt;
  final DateTime updatedAt;

  Media copyWith({
    int? id,
    String? modelType,
    int? modelId,
    String? uuid,
    String? collectionName,
    String? name,
    String? fileName,
    String? mimeType,
    String? disk,
    String? conversionsDisk,
    int? size,
    List<dynamic>? manipulations,
    List<dynamic>? customProperties,
    List<dynamic>? generatedConversions,
    List<dynamic>? responsiveImages,
    int? orderColumn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Media(
        id: id ?? this.id,
        modelType: modelType ?? this.modelType,
        modelId: modelId ?? this.modelId,
        uuid: uuid ?? this.uuid,
        collectionName: collectionName ?? this.collectionName,
        name: name ?? this.name,
        fileName: fileName ?? this.fileName,
        mimeType: mimeType ?? this.mimeType,
        disk: disk ?? this.disk,
        conversionsDisk: conversionsDisk ?? this.conversionsDisk,
        size: size ?? this.size,
        manipulations: manipulations ?? this.manipulations,
        customProperties: customProperties ?? this.customProperties,
        generatedConversions: generatedConversions ?? this.generatedConversions,
        responsiveImages: responsiveImages ?? this.responsiveImages,
        orderColumn: orderColumn ?? this.orderColumn,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        uuid: json["uuid"],
        collectionName: json["collection_name"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        conversionsDisk: json["conversions_disk"],
        size: json["size"],
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties:
            List<dynamic>.from(json["custom_properties"].map((x) => x)),
        generatedConversions:
            List<dynamic>.from(json["generated_conversions"].map((x) => x)),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "model_id": modelId,
        "uuid": uuid,
        "collection_name": collectionName,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "conversions_disk": conversionsDisk,
        "size": size,
        "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
        "generated_conversions":
            List<dynamic>.from(generatedConversions.map((x) => x)),
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

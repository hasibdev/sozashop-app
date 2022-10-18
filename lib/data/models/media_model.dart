import 'models_barrel.dart';

class MediaModel {
  MediaModel({
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

  MediaModel copyWith({
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
      MediaModel(
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

  factory MediaModel.fromRawJson(String str) =>
      MediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
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

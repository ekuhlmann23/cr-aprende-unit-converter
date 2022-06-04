import 'package:unit_converter/domain/dimension.dart';

class DimensionDTO {
  static Map<String, dynamic> toJson(Dimension dimension) {
    return {
      'name': dimension.name,
      'baseUnitName': dimension.baseUnitName,
    };
  }

  static Dimension fromJson(Map<String, dynamic> json) {
    return Dimension(json['name'] as String, json['baseUnitName'] as String);
  }
}

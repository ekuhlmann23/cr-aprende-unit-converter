// Data transfer object
import 'package:unit_converter/domain/unit.dart';

import 'dimension_dto.dart';

class UnitDTO {
  static Map<String, dynamic> toJson(Unit unit) {
    return {
      'name': unit.name,
      'symbol': unit.symbol,
      'conversionFactorToBaseUnit': unit.conversionFactorToBaseUnit,
      'dimension': DimensionDTO.toJson(unit.dimension)
    };
  }

  static Unit fromJson(Map<String, dynamic> json) {
    return Unit(
        json['name'] as String,
        json['symbol'] as String,
        (json['conversionFactorToBaseUnit'] as num).toDouble(),
        DimensionDTO.fromJson(json['dimension'] as Map<String, dynamic>));
  }
}

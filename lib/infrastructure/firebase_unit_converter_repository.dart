import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/i_unit_converter_repository.dart';
import 'package:unit_converter/domain/unit.dart';
import 'package:unit_converter/infrastructure/dtos/dimension_dto.dart';
import 'package:unit_converter/infrastructure/dtos/unit_dto.dart';

class FirebaseUnitConverterRepository implements IUnitConverterRepository {
  final FirebaseFirestore _firestore;
  CollectionReference<Dimension> _dimensionsCollection;
  CollectionReference<Unit> _unitsCollection;

  FirebaseUnitConverterRepository(this._firestore)
      : _dimensionsCollection =
            _firestore.collection('dimensions').withConverter<Dimension>(
                  fromFirestore: (doc, options) =>
                      DimensionDTO.fromJson(doc.data()!),
                  toFirestore: (dimension, options) =>
                      DimensionDTO.toJson(dimension),
                ),
        _unitsCollection = _firestore.collection('units').withConverter<Unit>(
              fromFirestore: (doc, options) => UnitDTO.fromJson(doc.data()!),
              toFirestore: (unit, options) => UnitDTO.toJson(unit),
            );

  @override
  Future<Iterable<Dimension>> getAllDimensions() async {
    final snapshots = await _dimensionsCollection.get();
    return snapshots.docs.map((doc) => doc.data());
  }

  @override
  Future<Iterable<Unit>> getAllUnitsForADimension(Dimension dimension) async {
    final snapshots = await _unitsCollection
        .where('dimension', isEqualTo: DimensionDTO.toJson(dimension))
        .get();
    return snapshots.docs.map((doc) => doc.data());
  }
}

class Dimension {
  final String name;
  final String baseUnitName;

  Dimension(this.name, this.baseUnitName);

  // Equality & hash code
  @override
  bool operator ==(Object other) {
    return other is Dimension &&
        name == other.name &&
        baseUnitName == other.baseUnitName;
  }

  @override
  int get hashCode => name.hashCode ^ baseUnitName.hashCode;
}

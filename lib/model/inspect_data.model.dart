class InspectionFormModel {
  final String pit;
  final String date;
  final String shift;
  final String typeBit;
  final int? diameterHole;
  final int? burden;
  final int? spacing;
  final int? totalHole;
  final double? averageDepth;
  final String cnUnit;
  final String? wet;
  final String? dry;
  final String? collapse;
  final String note;

  InspectionFormModel({
    required this.pit,
    required this.date,
    required this.shift,
    required this.typeBit,
    this.diameterHole,
    this.burden,
    this.spacing,
    this.totalHole,
    this.averageDepth,
    required this.cnUnit,
    this.wet,
    this.dry,
    this.collapse,
    required this.note,
  });
}

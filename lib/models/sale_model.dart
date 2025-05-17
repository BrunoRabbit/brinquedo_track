class SaleModel {
  final DateTime date;
  final double value;

  const SaleModel({
    required this.date,
    required this.value,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      date: DateTime.parse(json['data']),
      value: (json['valor'] as num).toDouble(),
    );
  }
}

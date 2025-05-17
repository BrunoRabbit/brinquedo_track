import 'package:intl/intl.dart';

class DailySaleModel {
  final String date;
  final double total;

  const DailySaleModel({
    required this.date,
    required this.total,
  });

  String get dateFormatted => DateFormat('dd/MM/yyyy').format(DateTime.parse(date));

  factory DailySaleModel.fromJson(Map<String, dynamic> json) {
    return DailySaleModel(
      date: json['date'],
      total: (json['total'] as num).toDouble(),
    );
  }
}

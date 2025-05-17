// ignore_for_file: avoid_redundant_argument_values

import 'package:brinquedo_track/models/sale_model.dart';

class CustomerListModel {
  final String name;
  final String email;
  final DateTime birthDate;
  final List<SaleModel> sales;
  final double totalSales;
  final double averageSale;
  final int saleCount;
  final String missingAlphabetLetter;

  const CustomerListModel({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.sales,
    required this.totalSales,
    required this.averageSale,
    required this.saleCount,
    required this.missingAlphabetLetter,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    final info = json['info'] ?? {};
    final details = info['detalhes'] ?? {};
    final stats = json['estatisticas'] ?? {};
    final vendas = stats['vendas'] as List? ?? [];

    final sales = vendas.map((v) => SaleModel.fromJson(v)).toList();
    final total = sales.fold<double>(0, (sum, s) => sum + s.value);
    final average = sales.isNotEmpty ? total / sales.length : 0;
    final name = info['nomeCompleto'] ?? '';

    final nascimento = details['nascimento'];
    final birthDate = nascimento != null
        ? DateTime.tryParse(nascimento)
        : DateTime(1970, 1, 1);

    return CustomerListModel(
      name: name,
      email: details['email'] ?? '',
      birthDate: birthDate!,
      sales: sales,
      totalSales: total,
      averageSale: average.toDouble(),
      saleCount: sales.length,
      missingAlphabetLetter: _missingWord(name),
    );
  }

  static String _missingWord(String name) {
    const alphabet = 'abcdefghijklmnopqrstuvwxyz';
    final nameLower = name.toLowerCase().replaceAll(' ', '');

    for (var word in alphabet.split('')) {
      if (!nameLower.contains(word)) {
        return word.toUpperCase();
      }
    }

    return '-';
  }
}

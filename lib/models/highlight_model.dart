// ignore_for_file: public_member_api_docs, sort_constructors_first
enum HighlightType {
  topVolume,
  topAverage,
  topFrequency;
}

extension HighlightTypeExtension on HighlightType {
  String get name {
    switch (this) {
      case HighlightType.topVolume:
        return 'Volume de vendas';
      case HighlightType.topFrequency:
        return 'Frequência de compras';
      case HighlightType.topAverage:
        return 'Media por venda';
    }
  }

  static HighlightType fromJson(String value) {
    switch (value) {
      case 'topVolume':
        return HighlightType.topVolume;
      case 'topAverage':
        return HighlightType.topAverage;
      case 'topFrequency':
        return HighlightType.topFrequency;
      default:
        throw Exception('Unknown highlight type: $value');
    }
  }
}

class HighlightModel {
  final HighlightType type;
  final HighlightCustomer customer;
  final HighlightMetric metric;

  const HighlightModel({
    required this.type,
    required this.customer,
    required this.metric,
  });

  factory HighlightModel.fromJson(Map<String, dynamic> map) {
    return HighlightModel(
      type: HighlightTypeExtension.fromJson(
        map['type'],
      ),
      customer: HighlightCustomer.fromJson(
        map['customer'],
      ),
      metric: HighlightMetric.fromJson(
        map['metric'],
      ),
    );
  }
}

class HighlightCustomer {
  final int id;
  final String name;
  final String email;

  HighlightCustomer({
    required this.id,
    required this.name,
    required this.email,
  });

  factory HighlightCustomer.fromJson(Map<String, dynamic> json) {
    return HighlightCustomer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class HighlightMetric {
  final String label;
  final double value;

  HighlightMetric({
    required this.label,
    required this.value,
  });

  factory HighlightMetric.fromJson(Map<String, dynamic> json) {
    return HighlightMetric(
      label: json['label'],
      value: (json['value'] as num).toDouble(),
    );
  }
}

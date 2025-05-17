class CustomerModel {
  final int? id;
  final String name;
  final String email;
  final DateTime birthDate;

  const CustomerModel({
    required this.name,
    required this.email,
    required this.birthDate,
    this.id,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String().split('T').first,
    };
  }
}

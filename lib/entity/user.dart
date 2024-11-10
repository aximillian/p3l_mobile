import 'pegawai.dart';
import 'customer.dart';

class User {
  final String role;
  final Pegawai? pegawai;
  final Customer? customer;

  User({required this.role, this.pegawai, this.customer});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['role'] == 'pegawai') {
      return User(
        role: json['role'],
        pegawai: Pegawai.fromJson(json['user']),
      );
    } else if (json['role'] == 'customer') {
      return User(
        role: json['role'],
        customer: Customer.fromJson(json['user']),
      );
    } else {
      throw Exception('Unknown role');
    }
  }
}

class Customer {
  final String idCustomer;
  final String username;
  final String tanggalLahir;
  final String jenisKelamin;
  final String alamatCustomer;
  final String nomorTelepon;
  final String emailCustomer;
  final String alergiObat;
  final int poinCustomer;
  final String tanggalRegistrasi;
  final String password;
  final String profileCustomer;

  Customer({
    required this.idCustomer,
    required this.username,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.alamatCustomer,
    required this.nomorTelepon,
    required this.emailCustomer,
    required this.alergiObat,
    required this.poinCustomer,
    required this.tanggalRegistrasi,
    required this.password,
    required this.profileCustomer,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      idCustomer: json['id_customer'],
      username: json['username'],
      tanggalLahir: json['tanggal_lahir'],
      jenisKelamin: json['jenis_kelamin'],
      alamatCustomer: json['alamat_customer'],
      nomorTelepon: json['nomor_telepon'],
      emailCustomer: json['email_customer'],
      alergiObat: json['alergi_obat'],
      poinCustomer: json['poin_customer'],
      tanggalRegistrasi: json['tanggal_registrasi'],
      password: json['password'],
      profileCustomer: json['profile_customer'],
    );
  }
}
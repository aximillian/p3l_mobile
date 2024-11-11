class Riwayat {
  final String idCustomer;  // This should be a String
  final String jenisTransaksi;
  final String statusTransaksi;
  final String keluhan;
  final String tanggalTransaksi;
  final double nominalTransaksi;

  Riwayat({
    required this.idCustomer,
    required this.jenisTransaksi,
    required this.statusTransaksi,
    required this.keluhan,
    required this.tanggalTransaksi,
    required this.nominalTransaksi,
  });

  // Update the fromJson method
  factory Riwayat.fromJson(Map<String, dynamic> json) {
    return Riwayat(
      idCustomer: json['id_customer'].toString(),  // Ensure it's a string
      jenisTransaksi: json['jenis_transaksi'] ?? '',
      statusTransaksi: json['status_transaksi'] ?? '',
      keluhan: json['keluhan'] ?? '',
      tanggalTransaksi: json['tanggal_transaksi'] ?? '',
      nominalTransaksi: json['nominal_transaksi'] is int
          ? (json['nominal_transaksi'] as int).toDouble()
          : json['nominal_transaksi'] is double
              ? json['nominal_transaksi']
              : 0.0,  // Ensure it's a double
    );
  }
}

class Ruangan {
  final String id;
  final String nomorRuangan;
  late final String status;

  Ruangan({
    required this.id,
    required this.nomorRuangan,
    required this.status,
  });

  factory Ruangan.fromJson(Map<String, dynamic> json) {
    return Ruangan(
      id: json['id'] ?? '',
      nomorRuangan: json['nomor_ruangan'] ?? '',
      status: json['status'] ?? 'available',
    );
  }
}

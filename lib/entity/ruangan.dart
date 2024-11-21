class Ruangan {
  final String id;  // This should be a String
  final String nomorRuangan;
  late final String status;

  Ruangan({
    required this.id,
    required this.nomorRuangan,
    required this.status,
  });

  factory Ruangan.fromJson(Map<String, dynamic> json) {
  return Ruangan(
    id: json['id'] ?? '',  // Ensure ID is never null
    nomorRuangan: json['nomor_ruangan'] ?? '',  // Default to empty string if missing
    status: json['status'] ?? 'available',  // Default to 'available' if status is missing
  );
}

}

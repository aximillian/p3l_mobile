class Treatment {
  final int? id;
  final String namaPerawatan;
  final String keteranganPerawatan;
  final String syaratPerawatan;
  final int? hargaPerawatan;
  final String? gambarPerawatan;

  Treatment({
    this.id,
    required this.namaPerawatan,
    required this.keteranganPerawatan,
    required this.syaratPerawatan,
    this.hargaPerawatan,
    this.gambarPerawatan,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int?,
      namaPerawatan: json['nama_perawatan'] ?? 'Unknown Treatment',
      keteranganPerawatan: json['keterangan_perawatan'] ?? 'No description', 
      syaratPerawatan: json['syarat_perawatan'] ?? 'No requirements',
      hargaPerawatan: json['harga_perawatan'] as int?,
      gambarPerawatan: json['gambar_perawatan'],
    );
  }
}

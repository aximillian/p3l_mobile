class Pegawai {
  final String id;
  final String idRuangan;
  final String jabatanPegawai;
  final String namaPegawai;
  final String alamatPegawai;
  final String nomorTelepon;
  final String statusPegawai;
  final String username;
  final String password;

  Pegawai({
    required this.id,
    required this.idRuangan,
    required this.jabatanPegawai,
    required this.namaPegawai,
    required this.alamatPegawai,
    required this.nomorTelepon,
    required this.statusPegawai,
    required this.username,
    required this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'],
      idRuangan: json['id_ruangan'],
      jabatanPegawai: json['jabatan_pegawai'],
      namaPegawai: json['nama_pegawai'],
      alamatPegawai: json['alamat_pegawai'],
      nomorTelepon: json['nomor_telepon'],
      statusPegawai: json['status_pegawai'],
      username: json['username'],
      password: json['password'],
    );
  }
}
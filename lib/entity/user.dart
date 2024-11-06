class User {
  final String username;
  final String jabatan;
  final String token;

  User({required this.username, required this.jabatan, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['user']['username'],
      jabatan: json['user']['jabatan_pegawai'],
      token: json['access_token'],
    );
  }
}

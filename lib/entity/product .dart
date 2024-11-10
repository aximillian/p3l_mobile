class Product {
  final int? id;
  final String namaProduk;
  final String keteranganProduk;
  final int? stockProduk;
  final int? hargaProduk;
  final String? gambarProduk;

  Product({
    this.id,
    required this.namaProduk,
    required this.keteranganProduk,
    this.stockProduk,
    this.hargaProduk,
    this.gambarProduk,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      namaProduk: json['nama_produk'] ?? 'Unknown Product',
      keteranganProduk: json['keterangan_produk'] ?? 'No description',
      stockProduk: json['stock_produk'] as int?,
      hargaProduk: json['harga_produk'] as int?,
      gambarProduk: json['gambar_produk'],
    );
  }
}

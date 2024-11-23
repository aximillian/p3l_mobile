import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final String stock;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      shadowColor: Colors.black54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Bagian Gambar Produk
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150.0, 
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 150.0);
              },
            ),
          ),

          // Bagian deskripsi produk
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Produk
                Text(
                  productName,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0), 

                // Row untuk stok dan harga
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Harga Produk
                    Text(
                      price,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 12.0,
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Stok Produk
                    Text(
                      'Stock: $stock',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

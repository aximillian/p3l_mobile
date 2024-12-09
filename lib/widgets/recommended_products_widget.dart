import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:intl/intl.dart'; // Add this import
import '../entity/product%20.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_screen.dart';

class RecommendedProductsWidget extends StatelessWidget {
  final Future<List<Product>> productsFuture;
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0); // Add this line

  RecommendedProductsWidget({super.key, required this.productsFuture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Products',
                style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold), // Apply GoogleFonts.lato
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductScreen()),
                  );
                },
                child: Text(
                  'See all >',
                  style: GoogleFonts.lato(fontSize: 14.0, color: AppTheme.blackColor), // Apply GoogleFonts.lato
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Product>>(
          future: productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            } else {
              final products = snapshot.data!;
              return SizedBox(
                height: 220.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product, otherProducts: products),
                          ),
                        );
                      },
                      child: Container(
                        width: 160.0,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  'http://atmabueatyapi.site/images/produk/${product.gambarProduk}',
                                  height: 100.0,
                                  width: 160.0,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(child: Icon(Icons.error));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.namaProduk,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                      ), // Apply GoogleFonts.lato
                                    ),
                                    Text(
                                      '${formatter.format(product.hargaProduk)},00', 
                                      style: GoogleFonts.lato(), 
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
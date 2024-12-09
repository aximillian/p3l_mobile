import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/product%20.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final Product product;
  final List<Product> otherProducts;

  ProductDetailScreen({super.key, required this.product, required this.otherProducts});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(product.namaProduk),
        backgroundColor: AppTheme.pinkColor,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'http://atmabueatyapi.site/images/produk/${product.gambarProduk}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          product.namaProduk,
                          style: GoogleFonts.lato(fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${formatter.format(product.hargaProduk)},00',
                          style: GoogleFonts.lato(fontSize: 24.0, color: Colors.green),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Stock: ${product.stockProduk}',
                          style: GoogleFonts.lato(fontSize: 16.0),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Description:',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          product.keteranganProduk,
                          style: GoogleFonts.lato(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16.0),
                const Text(
                  'Other Products:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: otherProducts.length,
                    itemBuilder: (context, index) {
                      final otherProduct = otherProducts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: otherProduct,
                                otherProducts: otherProducts,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    'http://atmabueatyapi.site/images/produk/${otherProduct.gambarProduk}',
                                    fit: BoxFit.cover,
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  otherProduct.namaProduk,
                                  style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${formatter.format(otherProduct.hargaProduk)},00',
                                  style: GoogleFonts.lato(fontSize: 14.0, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
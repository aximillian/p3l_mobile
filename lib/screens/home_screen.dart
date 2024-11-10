import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/product%20.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/screens/profile_screen.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/custom_search_field.dart';
import '../services/treatment_service.dart';
import '../services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TreatmentService _treatmentService = TreatmentService();
  final ProductService _productService = ProductService();
  List<Treatment> _searchTreatmentResults = [];
  List<Product> _searchProductResults = [];

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      try {
        final treatments =
            await _treatmentService.searchTreatmentsByName(query);
        final products = await _productService.searchProductsByName(query);
        setState(() {
          _searchTreatmentResults = treatments;
          _searchProductResults = products;
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } else {
      setState(() {
        _searchTreatmentResults = [];
        _searchProductResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/beauty.jpg',
      'assets/images/gambar_perawatan.jpg',
      'assets/images/gambar_produk.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_profile.jpeg'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchField(
              controller: _searchController,
              hintText: 'Search treatments and products...',
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  if (_searchTreatmentResults.isNotEmpty ||
                      _searchProductResults.isNotEmpty) ...[
                    if (_searchTreatmentResults.isNotEmpty) ...[
                      const Text('Treatment Results:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchTreatmentResults.length,
                        itemBuilder: (context, index) {
                          final treatment = _searchTreatmentResults[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(
                                treatment.namaPerawatan,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(treatment.keteranganPerawatan),
                            ),
                          );
                        },
                      ),
                    ],
                    if (_searchProductResults.isNotEmpty) ...[
                      const Text('Product Results:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchProductResults.length,
                        itemBuilder: (context, index) {
                          final product = _searchProductResults[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(
                                product.namaProduk,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(product.keteranganProduk),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/product%20.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/screens/profile_screen.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import '../widgets/bottom_navbar.dart';
import '../services/treatment_service.dart';
import '../services/product_service.dart';
import '../widgets/carousel_slider_widget.dart';
import '../widgets/recommended_treatments_widget.dart';
import '../widgets/recommended_products_widget.dart';
import '../widgets/about_us_widget.dart';
import '../widgets/meet_our_glowist_widget.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TreatmentService _treatmentService = TreatmentService();
  final ProductService _productService = ProductService();
  List<Treatment> _searchTreatmentResults = [];
  List<Product> _searchProductResults = [];
  late Future<List<Product>> _productsFuture;
  late Future<List<Treatment>> _treatmentsFuture;
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      _productsFuture = _productService.fetchProducts();
      _treatmentsFuture = _treatmentService.fetchTreatments();
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        setState(() {
          _isSearching = true;
        });
        try {
          final treatments = await _treatmentService.searchTreatmentsByName(query);
          final products = await _productService.searchProductsByName(query);
          setState(() {
            _searchTreatmentResults = treatments;
            _searchProductResults = products;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        } finally {
          setState(() {
            _isSearching = false;
          });
        }
      } else {
        setState(() {
          _searchTreatmentResults = [];
          _searchProductResults = [];
        });
      }
    });
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              if (_isSearching) 
                const CircularProgressIndicator()
              else if (_searchTreatmentResults.isNotEmpty || _searchProductResults.isNotEmpty) ...[
                if (_searchTreatmentResults.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Treatment Results:',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchTreatmentResults.length,
                    itemBuilder: (context, index) {
                      final treatment = _searchTreatmentResults[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            treatment.namaPerawatan,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Rp ${treatment.hargaPerawatan}'),
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 16),
                if (_searchProductResults.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Product Results:',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchProductResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchProductResults[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            product.namaProduk,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Rp ${product.hargaProduk}'),
                        ),
                      );
                    },
                  ),
                ],
              ] else ...[
                const CarouselSliderWidget(),
                RecommendedTreatmentsWidget(treatmentsFuture: _treatmentsFuture),
                RecommendedProductsWidget(productsFuture: _productsFuture),
                const Text(
                  'Meet Our Glowist',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const MeetOurGlowistWidget(),
                AboutUsWidget(),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

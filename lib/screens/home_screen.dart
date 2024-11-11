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
                
                const Text(
                  'Schedules',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildSchedules(),
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

  Widget _buildSchedules() {
    return SizedBox(
      height: 300, // Adjust height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildScheduleCard('Doctor Schedule', _buildDoctorSchedule()),
          _buildScheduleCard('Beautician Schedule', _buildBeauticianSchedule()),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String title, Widget scheduleContent) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        width: 300, // Adjust width as needed
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(child: scheduleContent),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorSchedule() {
    final schedule = {
      'Tuesday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Anita'],
      },
      'Wednesday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky'],
      },
      'Thursday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Becky'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Charlie'],
      },
      'Friday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Becky'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
      'Saturday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Charlie'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
      'Sunday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Charlie'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
    };

    return ListView(
      shrinkWrap: true,
      children: schedule.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...entry.value.entries.map((shiftEntry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shiftEntry.key,
                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          shiftEntry.value.join(', '),
                          style: const TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBeauticianSchedule() {
    final schedule = {
      'Tuesday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Cintya', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Elisa', 'Fendy'],
      },
      'Wednesday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Elisa', 'Dio'],
      },
      'Thursday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Fendy'],
      },
      'Friday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Cintya', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Dio'],
      },
      'Saturday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Fendy'],
      },
      'Sunday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Dio'],
      },
    };

    return ListView(
      shrinkWrap: true,
      children: schedule.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...entry.value.entries.map((shiftEntry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shiftEntry.key,
                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          shiftEntry.value.join(', '),
                          style: const TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
    );
  }
}

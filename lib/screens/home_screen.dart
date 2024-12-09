import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/product%20.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/helper/shared_preferences.dart';
import 'package:p3l_mobile/screens/login_screen.dart';
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
import '../widgets/schedule_widgets.dart';
import 'package:p3l_mobile/screens/treatment_detail_screen.dart';
import 'package:p3l_mobile/screens/product_detail_screen.dart';
import '../widgets/custom_search_field.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
  final TextEditingController _searchController = TextEditingController();
  String _searchType = 'Treatment'; // Default search type
  String? _username;
  String? _userRole;
  String? _jabatanPegawai;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageHelper.getUserData();
    final userRole = await StorageHelper.getUserRole();
    setState(() {
      _username = userData?['username'];
      _userRole = userRole;
      if (userRole == 'pegawai') {
        _jabatanPegawai = userData?['jabatan_pegawai'];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (query.isNotEmpty) {
        setState(() {
          _isSearching = true;
        });
        try {
          if (_searchType == 'Treatment') {
            final treatments = await _treatmentService.searchTreatmentsByName(query);
            setState(() {
              _searchTreatmentResults = treatments
                ..sort((a, b) => a.namaPerawatan.compareTo(b.namaPerawatan));
              _searchProductResults = [];
            });
          } else {
            final products = await _productService.searchProductsByName(query);
            setState(() {
              _searchTreatmentResults = [];
              _searchProductResults = products
                ..sort((a, b) => a.namaProduk.compareTo(b.namaProduk));
            });
          }
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning, ';
    } else if (hour < 17) {
      return 'Good afternoon, ';
    } else if (hour < 20) {
      return 'Good evening, ';
    } else {
      return 'Good night, ';
    }
  }

  IconData _getGreetingIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Icons.wb_sunny;
    } else if (hour < 17) {
      return Icons.wb_cloudy;
    } else if (hour < 20) {
      return Icons.nights_stay;
    } else {
      return Icons.bedtime;
    }
  }

  Color _getGreetingIconColor() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Colors.yellow;
    } else if (hour < 17) {
      return Colors.orange;
    } else if (hour < 20) {
      return Colors.blue;
    } else {
      return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_username != null)
              Row(
                children: [
                  Icon(_getGreetingIcon(), size: 25, color: _getGreetingIconColor()),
                  const SizedBox(width: 5),
                  Text(
                    '${_getGreeting()}$_username',
                    style: GoogleFonts.lato(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.lato(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.waving_hand, size: 25, color: Color.fromARGB(255, 200, 120, 0)),
                ],
              ),
            if (_userRole != null)
              Text(
                _userRole == 'pegawai' 
                  ? (_jabatanPegawai == 'Kepala Klinik' ? 'Head of Clinic' : 'Professional Beautician')
                  : 'Valued Customer',
                style: GoogleFonts.lato(
                  fontSize: 16, 
                  fontWeight: FontWeight.normal, 
                ),
              ),
          ],
        ),
        backgroundColor: AppTheme.pinkColor,
        automaticallyImplyLeading: false,
        elevation: 10, 
        shadowColor: Colors.black.withOpacity(0.5), 
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            onPressed: () async {
              final token = await StorageHelper.getToken();
              if (token == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }
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
                child: Column(
                  children: [
                    Text(
                      'Your beauty skin is our priority',
                      style: GoogleFonts.lato(
                        fontSize: 20, // Larger font size
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: _searchType,
                        items: <String>['Treatment', 'Product'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _searchType = newValue!;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isSearching) 
                const CircularProgressIndicator()
              else if (_searchController.text.isNotEmpty && (_searchTreatmentResults.isNotEmpty || _searchProductResults.isNotEmpty)) ...[
                if (_searchTreatmentResults.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Treatment Results:',
                      style: GoogleFonts.lato(
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TreatmentDetailScreen(
                                  treatment: treatment,
                                  otherTreatments: _searchTreatmentResults,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 16),
                if (_searchProductResults.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Product Results:',
                      style: GoogleFonts.lato(
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: product,
                                  otherProducts: _searchProductResults,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ] else if (_searchController.text.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      const Icon(Icons.search_off, size: 80, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        _searchType == 'Treatment'
                          ? 'No treatments found with that name'
                          : 'No products found with that name',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const CarouselSliderWidget(),
                RecommendedTreatmentsWidget(treatmentsFuture: _treatmentsFuture),
                RecommendedProductsWidget(productsFuture: _productsFuture),
                Text(
                  'Meet Our Glowist',
                  style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const MeetOurGlowistWidget(),
                const AboutUsWidget(),
                const SizedBox(height: 16),
                
                Text(
                  'Schedules',
                  style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const SchedulesWidget(),
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

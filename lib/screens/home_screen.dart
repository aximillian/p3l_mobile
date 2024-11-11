import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/product%20.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/screens/profile_screen.dart';
import 'package:p3l_mobile/screens/product_screen.dart';
import 'package:p3l_mobile/screens/treatment_screen.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import '../widgets/bottom_navbar.dart';
// import '../widgets/custom_search_field.dart';
import '../services/treatment_service.dart';
import '../services/product_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:p3l_mobile/screens/product_detail_screen.dart';
import 'package:p3l_mobile/screens/treatment_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final TextEditingController _searchController = TextEditingController();
  final TreatmentService _treatmentService = TreatmentService();
  final ProductService _productService = ProductService();
  List<Treatment> _searchTreatmentResults = [];
  List<Product> _searchProductResults = [];
  int _currentIndex = 0;
  late Future<List<Product>> _productsFuture;
  late Future<List<Treatment>> _treatmentsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.fetchProducts();
    _treatmentsFuture = _treatmentService.fetchTreatments();
  }

  // void _onSearchChanged(String query) async {
  //   if (query.isNotEmpty) {
  //     try {
  //       final treatments =
  //           await _treatmentService.searchTreatmentsByName(query);
  //       final products = await _productService.searchProductsByName(query);
  //       setState(() {
  //         _searchTreatmentResults = treatments;
  //         _searchProductResults = products;
  //       });
  //     } catch (e) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  //     }
  //   } else {
  //     setState(() {
  //       _searchTreatmentResults = [];
  //       _searchProductResults = [];
  //     });
  //   }
  // }

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
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: CustomSearchField(
              //     controller: _searchController,
              //     hintText: 'Search treatments and products...',
              //     onChanged: _onSearchChanged,
              //   ),
              // ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: imgList.map((imgPath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(imgPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((url) {
                  int index = imgList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended Treatments',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TreatmentScreen()),
                        );
                      },
                      child: const Text(
                        'See all >',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Treatment>>(
                future: _treatmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No treatments available'));
                  } else {
                    final treatments = snapshot.data!;
                    return SizedBox(
                      height: 220.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: treatments.length,
                        itemBuilder: (context, index) {
                          final treatment = treatments[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TreatmentDetailScreen(treatment: treatment, otherTreatments: treatments),
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
                                        'http://10.0.2.2:8000/images/perawatan/${treatment.gambarPerawatan}',
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
                                            treatment.namaPerawatan,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('Rp ${treatment.hargaPerawatan}'),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended Products',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductScreen()),
                        );
                      },
                      child: const Text(
                        'See all >',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Product>>(
                future: _productsFuture,
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
                                        'http://10.0.2.2:8000/images/produk/${product.gambarProduk}',
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
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('Rp ${product.hargaProduk}'),
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
              const SizedBox(height: 16),

              // Meet Our Glowist
              const Text(
                'Meet Our Glowist',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CarouselSlider(
                options: CarouselOptions(
                  height: 450.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/images/dokter.png'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Doctor',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'At Natural Beauty Center, our doctors are dedicated professionals committed to providing each patient with the highest level of care tailored to individual skin types and needs. With deep knowledge and extensive experience in skin health, our doctors use the latest technology and safe methods to help you achieve healthy, radiant skin. Your safety and comfort are our top priorities!',
                                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/images/beautician.png'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Beautician',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Our team of beauticians consists of skilled professionals who understand precisely how to care for your skin. They are ready to provide a relaxing and comprehensive experience, from facials and skin treatments to soothing body therapies. Our beauticians are dedicated to making you feel refreshed, relaxed, and confident, with treatments personalized to meet your skin’s unique needs.',
                                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/images/staff.png'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Staff',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'At Natural Beauty Center, our dedicated team of highly trained professionals prioritizes your comfort and satisfaction. Passionate about beauty and wellness, each staff member is committed to providing exceptional service tailored to your unique needs. We strive to create a rejuvenating and memorable experience that supports your journey to radiant beauty.',
                                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // About Us Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Us',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Natural Beauty Center, the beauty clinic that offers the finest treatments for your skin and body!',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'With experienced professionals and state-of-the-art technology, we are here to help you achieve a radiant, natural beauty. At Natural Beauty Center, we believe that every individual\'s uniqueness deserves care and enhancement. Enjoy a personalized and comprehensive experience, from facials and skincare treatments to relaxing body therapies. Trust us with your beauty needs, and feel the real transformation with stunning results!',
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

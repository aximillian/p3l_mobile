import 'package:flutter/material.dart';
import 'package:p3l_mobile/routes.dart'; // Pastikan sudah import Routes untuk navigasi
import 'package:p3l_mobile/main.dart'; // Import navigatorKey
import 'product_screen.dart'; // Import ProductScreen
import 'treatment_screen.dart'; // Import TreatmentScreen
import 'profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Halaman yang akan ditampilkan di bawah
  static final List<Widget> _pages = <Widget>[
    ProductScreen(),
    TreatmentScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi global untuk pindah ke halaman baru
    if (index == 0) {
      navigatorKey.currentState
          ?.pushNamed(Routes.product); // Navigasi ke ProductScreen
    } else if (index == 1) {
      navigatorKey.currentState
          ?.pushNamed(Routes.treatment); // Navigasi ke TreatmentScreen
    } else if (index == 2) {
      navigatorKey.currentState
          ?.pushNamed(Routes.profile); // Navigasi ke ProfileScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text(
            "Pilih menu di bawah untuk navigasi"), // Placeholder, karena kita pindah ke halaman penuh
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex =
                index; // Untuk visual feedback pada BottomNavigationBar
          });
          _onItemTapped(index); // Navigasi ke halaman penuh secara global
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Perawatan',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

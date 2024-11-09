import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes/routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24, // Atur lebar ikon
            height: 24, // Atur tinggi ikon
            child: SvgPicture.asset('assets/icons/home.svg'),
          ), 
          label: 'Home',
          ),

        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/icons/product.svg'),
          ),
          label: 'Product',
          ),
          
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/icons/treatment.svg'),
          ),          
          label: 'Treatment',
          ),
      ],

      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.produk);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.perawatan);
            break;
        }
      },
    );
  }
}

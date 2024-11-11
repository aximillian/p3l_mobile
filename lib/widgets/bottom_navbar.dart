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
            width: 24, 
            height: 24, 
            child: SvgPicture.asset('assets/icons/home.svg'),
          ), 
          label: '',
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
        
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/icons/jadwal.svg'),
          ),
          label: 'Schedule',
          ),
      ],

      selectedItemColor: Colors.black, 
      unselectedItemColor: Colors.grey, 
      
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
          case 3:
            Navigator.pushNamed(context, AppRoutes.jadwal);
            break;
        }
      },
    );
  }
}

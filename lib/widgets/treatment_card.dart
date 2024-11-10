import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class TreatmentCard extends StatelessWidget {
  final String imageUrl;
  final String treatmentName;
  final String price;
  final String requirements;

  const TreatmentCard({
    super.key,
    required this.imageUrl,
    required this.treatmentName,
    required this.price,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Gambar Perawatan
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: _buildImage(imageUrl),
          ),

          // Bagian deskripsi perawatan
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Nama Perawatan
                Text(
                  treatmentName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0), 

                // Harga Perawatan
                Text(
                  'Rp $price',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppTheme.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),

                // Syarat Perawatan
                Text(
                  requirements,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 150.0,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $imageUrl'); // Log URL gambar
          print('Error details: $error'); // Log detail error
          return const Icon(Icons.broken_image, size: 150.0);
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 150.0,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $imageUrl'); // Log URL gambar
          print('Error details: $error'); // Log detail error
          return const Icon(Icons.broken_image, size: 150.0);
        },
      );
    }
  }
}

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
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Gambar Perawatan
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(15.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 150.0,
                height: 150.0,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 150.0);
                },
              ),
            ),
            
            // Bagian deskripsi perawatan
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Nama Perawatan
                    Text(
                      treatmentName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blackColor,
                      ),
                    ),
                    const SizedBox(height: 8.0), 

                    // Harga Perawatan
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppTheme.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    const Text(
                      "Syarat Perawatan", 
                      style: TextStyle(
                        fontSize: 16.0, 
                        fontWeight: 
                        FontWeight.bold,
                        color: AppTheme.blackColor,
                      ),
                    ),

                    // Syarat Perawatan
                    Text(
                      requirements,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

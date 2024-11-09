import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String imageUrl;
  final String treatmentName;
  final String price;
  final String requirements;

  const TreatmentCard({
    Key? key,
    required this.imageUrl,
    required this.treatmentName,
    required this.price,
    required this.requirements,
  }) : super(key: key);

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
          // Gambar Perawatan di bagian atas
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150.0, // Sesuaikan tinggi gambar
            ),
          ),
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
                const SizedBox(height: 4.0), // Jarak antar elemen
                // Harga Perawatan
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
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
        ],
      ),
    );
  }
}

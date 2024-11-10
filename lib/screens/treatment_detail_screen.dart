import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class TreatmentDetailScreen extends StatelessWidget {
  final Treatment treatment;

  const TreatmentDetailScreen({Key? key, required this.treatment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(treatment.namaPerawatan),
        backgroundColor: AppTheme.pinkColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'http://10.0.2.2:8000/images/perawatan/${treatment.gambarPerawatan}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                treatment.namaPerawatan,
                style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Rp ${treatment.hargaPerawatan}',
                style: const TextStyle(fontSize: 24.0, color: Colors.green),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Requirements:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                treatment.syaratPerawatan,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              const Divider(color: Colors.grey),
              const SizedBox(height: 16.0),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                treatment.keteranganPerawatan,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
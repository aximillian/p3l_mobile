import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class TreatmentDetailScreen extends StatelessWidget {
  final Treatment treatment;
  final List<Treatment> otherTreatments;

  const TreatmentDetailScreen({super.key, required this.treatment, required this.otherTreatments});

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
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
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
              const SizedBox(height: 16.0),
              const Divider(color: Colors.grey),
              const SizedBox(height: 16.0),
              const Text(
                'Other Treatments:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: otherTreatments.length,
                  itemBuilder: (context, index) {
                    final otherTreatment = otherTreatments[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TreatmentDetailScreen(
                              treatment: otherTreatment,
                              otherTreatments: otherTreatments,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  'http://10.0.2.2:8000/images/perawatan/${otherTreatment.gambarPerawatan}',
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                otherTreatment.namaPerawatan,
                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp ${otherTreatment.hargaPerawatan}',
                                style: const TextStyle(fontSize: 14.0, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
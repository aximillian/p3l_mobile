import 'package:flutter/material.dart';
import 'package:p3l_mobile/services/treatment_service.dart';
import 'package:p3l_mobile/widgets/treatment_card.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  _TreatmentScreenState createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  late Future<List<Treatment>> futureTreatments;

  @override
  void initState() {
    super.initState();
    futureTreatments = TreatmentService().fetchTreatments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatments'),
      ),
      body: FutureBuilder<List<Treatment>>(
        future: futureTreatments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No treatments available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final treatment = snapshot.data![index];
                return TreatmentCard(
                  imageUrl: treatment.gambarPerawatan ?? '',
                  treatmentName: treatment.namaPerawatan,
                  price: treatment.hargaPerawatan.toString(),
                  requirements: treatment.syaratPerawatan,
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l_mobile/services/treatment_service.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/widgets/treatment_card.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';
import 'package:p3l_mobile/screens/treatment_detail_screen.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  _TreatmentScreenState createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  final TreatmentService _treatmentService = TreatmentService();
  late Future<List<Treatment>> _treatmentFuture;

  @override
  void initState() {
    super.initState();
    _treatmentFuture = _treatmentService.fetchTreatments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatments'),
        backgroundColor: AppTheme.pinkColor,
        automaticallyImplyLeading: false,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Treatment>>(
          future: _treatmentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No treatments available'));
            } else {
              final treatments = snapshot.data!;
              final formatter = NumberFormat.currency(
                  locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: treatments.length,
                  itemBuilder: (context, index) {
                    final treatment = treatments[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TreatmentDetailScreen(
                                treatment: treatment,
                                otherTreatments: treatments),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TreatmentCard(
                          imageUrl:
                              'http://atmabueatyapi.site/images/perawatan/${treatment.gambarPerawatan}',
                          treatmentName: treatment.namaPerawatan,
                          price:
                              '${formatter.format(treatment.hargaPerawatan)},00',
                          requirements: treatment.syaratPerawatan,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p3l_mobile/entity/treatment.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TreatmentDetailScreen extends StatelessWidget {
  final Treatment treatment;
  final List<Treatment> otherTreatments;
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  TreatmentDetailScreen({super.key, required this.treatment, required this.otherTreatments});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          treatment.namaPerawatan,
          style: GoogleFonts.lato(),
        ),
        backgroundColor: AppTheme.pinkColor,
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
        child: SingleChildScrollView(
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
                            'http://atmabueatyapi.site/images/perawatan/${treatment.gambarPerawatan}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          treatment.namaPerawatan,
                          style: GoogleFonts.lato(fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${formatter.format(treatment.hargaPerawatan)},00',
                          style: GoogleFonts.lato(fontSize: 24.0, color: Colors.green),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Requirements:',
                          style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          treatment.syaratPerawatan,
                          style: GoogleFonts.lato(fontSize: 16.0),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 16.0),
                        Text(
                          'Description:',
                          style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          treatment.keteranganPerawatan,
                          style: GoogleFonts.lato(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16.0),
                Text(
                  'Other Treatments:',
                  style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                    'http://atmabueatyapi.site/images/perawatan/${otherTreatment.gambarPerawatan}',
                                    fit: BoxFit.cover,
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  otherTreatment.namaPerawatan,
                                  style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${formatter.format(otherTreatment.hargaPerawatan)},00',
                                  style: GoogleFonts.lato(fontSize: 14.0, color: Colors.green),
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
      ),
    );
  }
}
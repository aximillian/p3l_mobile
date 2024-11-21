import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetOurGlowistWidget extends StatelessWidget {
  const MeetOurGlowistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 450.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/dokter.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Doctor',
                      style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'At Natural Beauty Center, our doctors are dedicated professionals committed to providing each patient with the highest level of care tailored to individual skin types and needs. With deep knowledge and extensive experience in skin health, our doctors use the latest technology and safe methods to help you achieve healthy, radiant skin. Your safety and comfort are our top priorities!',
                      style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/beautician.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Beautician',
                      style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Our team of beauticians consists of skilled professionals who understand precisely how to care for your skin. They are ready to provide a relaxing and comprehensive experience, from facials and skin treatments to soothing body therapies. Our beauticians are dedicated to making you feel refreshed, relaxed, and confident, with treatments personalized to meet your skin’s unique needs.',
                      style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/staff.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Staff',
                      style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'At Natural Beauty Center, our dedicated team of highly trained professionals prioritizes your comfort and satisfaction. Passionate about beauty and wellness, each staff member is committed to providing exceptional service tailored to your unique needs. We strive to create a rejuvenating and memorable experience that supports your journey to radiant beauty.',
                      style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
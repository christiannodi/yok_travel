import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introduction2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // ID Circle on the top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.02), // Responsif padding
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'ID',
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: screenWidth * 0.04, // Responsif font size
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.4), // Responsif jarak vertikal
                  // Main Title Text
                  Text(
                    'Komunitas tanpa \nbatas.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.tiltWarp(
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.08, // Responsif font size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.15), // Responsif jarak vertikal
                  Text(
                    'Help Us!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04, // Responsif font size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Bantu kami dan user lainnya explore tempat asik',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.035, // Responsif font size
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Positioned Image (First Image)
            Positioned(
              top: screenHeight * 0.06,
              left: -screenWidth * 0.05, // Responsif posisi horizontal
              child: Container(
                width: screenWidth * 0.85, // Responsif ukuran lebar gambar
                height: screenHeight * 0.45, // Responsif ukuran tinggi gambar
                child: Image.asset('assets/camping3.png'), // Gambar pertama
              ),
            ),
            // Button at the bottom center
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0, right: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login'); // Tambah fungsi tombol di sini
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1, // Responsif padding tombol
                        vertical: screenHeight * 0.02), // Responsif padding tombol
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Mulai',
                    style: GoogleFonts.ubuntu(
                      fontSize: screenWidth * 0.045, // Responsif font size tombol
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

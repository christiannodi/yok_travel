import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introduction1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'ID',
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.35), // Adjust height based on screen size
                  // Main Title Text
                  Text(
                    'Cari tempat liburan\nmu disini.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.tiltWarp(
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.06, // Responsive text size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.2),
                  Text(
                    'No Wacana Wacana!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04, // Responsive text size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ga usah fafifu buat cari destinasi tempat mainmu',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.035, // Responsive text size
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Positioned Image (First Image)
            Positioned(
              top: screenHeight * 0.15,
              left: -screenWidth * 0.2, // Responsive left position
              child: CircleAvatar(
                radius: screenWidth * 0.3, // Responsive radius
                backgroundImage: AssetImage('assets/camping1.png'),
              ),
            ),
            // Positioned Image (Second Image)
            Positioned(
              bottom: screenHeight * 0.25,
              right: -screenWidth * 0.1, // Responsive right position
              child: CircleAvatar(
                radius: screenWidth * 0.3, // Responsive radius
                backgroundImage: AssetImage('assets/camping2.png'),
              ),
            ),
            // Button at the bottom center
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0, right: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/introduction2'); // Button functionality
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Lanjut',
                    style: GoogleFonts.ubuntu(
                      fontSize: screenWidth * 0.045, // Responsive button text
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

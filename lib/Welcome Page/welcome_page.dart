import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/introduction1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200], // Set the background color
      body: SafeArea(
        child: Center(
          child: Text(
            'Yok.',
            style: GoogleFonts.tiltWarp( // Apply Tilt Warp font
              textStyle: TextStyle(
                fontSize: 36, // Adjust font size
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.black, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}

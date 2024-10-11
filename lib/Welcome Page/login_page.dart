import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final double horizontalPadding;

  LoginPage({this.horizontalPadding = 10});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isUsernameFocused = false;
  bool _isPasswordFocused = false;
  bool _isPressed = false;
  double _buttonOpacity = 1.0; // Opacity untuk tombol

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

    // Mulai animasi menghilangkan tombol selama 2 detik
    setState(() {
      _isPressed = true;
      _buttonOpacity = 0.0; // Ubah opacity menjadi 0
    });

    // Setelah 2 detik, kembalikan tombol ke keadaan semula
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _isPressed = false;
        _buttonOpacity = 1.0; // Kembalikan opacity menjadi 1
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          'Welcome!',
                          style: GoogleFonts.tiltWarp(
                            fontSize: 45,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          'Kaum mendang mending\n yang pengen liburan',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tienne(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 80),

                        // Username field with drop shadow and active effect
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: FocusScope(
                            onFocusChange: (isFocused) {
                              setState(() {
                                _isUsernameFocused = isFocused;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(27),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                border: Border.all(
                                  color: _isUsernameFocused
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/username.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        hintText: 'username',
                                        hintStyle: GoogleFonts.aBeeZee(
                                          fontSize: 16,
                                          color: Colors.black38,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Password field with drop shadow and active effect
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: FocusScope(
                            onFocusChange: (isFocused) {
                              setState(() {
                                _isPasswordFocused = isFocused;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(21),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                border: Border.all(
                                  color: _isPasswordFocused
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/password.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        hintText: 'password',
                                        hintStyle: GoogleFonts.aBeeZee(
                                          fontSize: 16,
                                          color: Colors.black38,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 0),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: widget.horizontalPadding),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Lupa password?',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Login button with opacity animation
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                _isPressed = true;
                              });
                            },
                            onTapUp: (_) {
                              _handleLogin(); // Menangani login setelah tombol ditekan
                            },
                            onTapCancel: () {
                              setState(() {
                                _isPressed = false;
                              });
                            },
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 2), // Durasi perubahan opacity
                              opacity: _buttonOpacity, // Menggunakan opacity yang diatur
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _isPressed ? Colors.blue[200] : Colors.black,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                                child: Center(
                                  child: Text(
                                    'Masuk',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tidak punya akun? ',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Daftar',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 280),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.6,
                    left: screenWidth * 0.2, // Responsif posisi horizontal
                    child: Container(
                      width: screenWidth * 0.85, // Responsif ukuran lebar gambar
                      height: screenHeight * 0.45, // Responsif ukuran tinggi gambar
                      child: Image.asset('assets/camping.png'), // Gambar pertama
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

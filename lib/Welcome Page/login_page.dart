import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yok_travel/api_connection/api_connection.dart';

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
  bool _isLoading = false; // State untuk indikator loading
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String user_name = _usernameController.text;
    String user_password = _passwordController.text;

    // Validasi input
    if (user_name.isEmpty || user_password.isEmpty) {
      setState(() {
        _errorMessage = "Username dan password tidak boleh kosong.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Kirim data ke backend (sesuaikan dengan alamat server)
    final url = Uri.parse(API.logIn); // Ganti URL dengan backend Anda
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_name': user_name,
          'user_password': user_password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          // Jika login berhasil
          print('Login sukses: ${data['user_full_name']}');
        } else {
          // Jika username/password salah
          setState(() {
            _errorMessage = "Username atau password salah!";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Username atau password salah!";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Terjadi kesalahan pada jaringan.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

                        // Username field
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: _buildInputField(
                              context, 'username', _usernameController, _isUsernameFocused),
                        ),
                        const SizedBox(height: 10),

                        // Password field
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: _buildInputField(
                              context, 'password', _passwordController, _isPasswordFocused, obscureText: true),
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

                        // Display error message
                        if (_errorMessage != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],

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
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                  )
                                      : Text(
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
                    left: screenWidth * 0.2,
                    child: Container(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.45,
                      child: Image.asset('assets/camping.png'), // Gambar untuk halaman login
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

  Widget _buildInputField(BuildContext context, String hintText, TextEditingController controller,
      bool isFocused, {bool obscureText = false}) {
    return FocusScope(
      onFocusChange: (isFocused) {
        setState(() {
          if (hintText == 'username') _isUsernameFocused = isFocused;
          if (hintText == 'password') _isPasswordFocused = isFocused;
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
            color: isFocused ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/$hintText.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.aBeeZee(
                    fontSize: 16,
                    color: Colors.black38,
                  ),
                  border: InputBorder.none,
                ),
                obscureText: obscureText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

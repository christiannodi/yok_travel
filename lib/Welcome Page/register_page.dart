import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:yok_travel/api_connection/api_connection.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  final double horizontalPadding;

  RegisterPage({this.horizontalPadding = 10});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool _isUsernameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isRePasswordFocused = false;
  bool _isLoading = false; // State for loading indicator
  String? _errorMessage; // State for error message

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    String user_name = _usernameController.text;
    String user_email = _emailController.text;
    String user_password = _passwordController.text;
    String userRePassword = _rePasswordController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset error message before processing
    });

    // Validation checks
    if (user_name.isEmpty || user_email.isEmpty || user_password.isEmpty || userRePassword.isEmpty) {
      setState(() {
        _errorMessage = 'Ada yang masih kosong!';
        _isLoading = false; // Stop loading if validation fails
      });
      return;
    }

    if (user_password != userRePassword) {
      setState(() {
        _errorMessage = 'Passwords tidak cocok!';
        _isLoading = false; // Stop loading if validation fails
      });
      return;
    }

    // Send data to the PHP script
    final url = Uri.parse(API.signUp);
    try {
      final response = await http.post(
        url,
        body: {
          'user_email': user_email,
          'user_name': user_name,
          'user_password': user_password,
        },
      );

      final responseData = jsonDecode(response.body);

      if (responseData['success']) {
        _showSuccess('Registration successful!');
        Navigator.pushNamed(context, '/login');
      } else {
        setState(() {
          _errorMessage = 'Registration failed: ${responseData['error']}';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred: $error';
      });
    } finally {
      setState(() {
        _isLoading = false; // Ensure loading stops after response
      });
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.green))),
    );
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
                      crossAxisAlignment: CrossAxisAlignment.start, // Pindahkan teks ke kiri
                      children: [
                        const SizedBox(height: 150),

                        // "Buat Akun" di sebelah kiri
                        Text(
                          'Buat Akun',
                          style: GoogleFonts.tiltWarp(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left, // Menyelaraskan teks ke kiri
                        ),

                        const SizedBox(height: 0),

                        // Sub-title di bawahnya, juga di kiri
                        Text(
                          ' Gabung dan eksplor tempat menarik',
                          textAlign: TextAlign.left, // Menyelaraskan teks ke kiri
                          style: GoogleFonts.tienne(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Username field
                        _buildInputField(
                          hintText: 'username',
                          controller: _usernameController,
                          isFocused: _isUsernameFocused,
                          assetName: 'assets/username.png', // Menentukan gambar username
                          onFocusChange: (isFocused) {
                            setState(() {
                              _isUsernameFocused = isFocused;
                            });
                          },
                        ),
                        const SizedBox(height: 10),

                        // Email field
                        _buildInputField(
                          hintText: 'email',
                          controller: _emailController,
                          isFocused: _isEmailFocused,
                          assetName: 'assets/email.png', // Menentukan gambar email
                          onFocusChange: (isFocused) {
                            setState(() {
                              _isEmailFocused = isFocused;
                            });
                          },
                        ),
                        const SizedBox(height: 10),

                        // Password field
                        _buildInputField(
                          hintText: 'password',
                          controller: _passwordController,
                          isFocused: _isPasswordFocused,
                          assetName: 'assets/password.png', // Menentukan gambar password
                          obscureText: true,
                          onFocusChange: (isFocused) {
                            setState(() {
                              _isPasswordFocused = isFocused;
                            });
                          },
                        ),
                        const SizedBox(height: 10),

                        // Re-Password field
                        _buildInputField(
                          hintText: 're-password',
                          controller: _rePasswordController,
                          isFocused: _isRePasswordFocused,
                          assetName: 'assets/password.png', // Menentukan gambar re-password
                          obscureText: true,
                          onFocusChange: (isFocused) {
                            setState(() {
                              _isRePasswordFocused = isFocused;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // Display error message
                        if (_errorMessage != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],

                        // Register button with loading state
                        _isLoading
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                          child: GestureDetector(
                            onTap: _handleRegister,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
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
                                  'Daftar',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.0, // Responsif posisi horizontal
                    child: Container(
                      width: screenWidth * 1.8, // Responsif ukuran lebar gambar
                      height: screenHeight * 0.28, // Responsif ukuran tinggi gambar
                      child: Image.asset('assets/register.png'), // Gambar untuk halaman register
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

  Widget _buildInputField({
    required String hintText,
    required TextEditingController controller,
    required bool isFocused,
    required String assetName, // Menambahkan parameter assetName
    required void Function(bool) onFocusChange,
    bool obscureText = false,
  }) {
    return FocusScope(
      onFocusChange: onFocusChange,
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
              assetName, // Menampilkan gambar yang sesuai
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

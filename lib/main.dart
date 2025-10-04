import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ID Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(218, 20, 70, 46),
        ),
        useMaterial3: true,
      ),
      home: const StudentIDCard(),
    );
  }
}

class StudentIDCard extends StatefulWidget {
  const StudentIDCard({super.key});

  @override
  State<StudentIDCard> createState() => _StudentIDCardState();
}

class _StudentIDCardState extends State<StudentIDCard> {
  // Default background color (dark green)
  Color cardColor = const Color.fromARGB(255, 21, 39, 24);

  // Function to generate random color
  void _changeColor() {
    final Random random = Random();
    setState(() {
      cardColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    });
  }

  // List of Google Fonts
  final List<TextStyle Function()> _fonts = [
    () => GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
    () => GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold),
    () => GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
    () => GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
    () => GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.bold),
  ];

  // Current font style
  TextStyle _currentFont = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // Function to change font randomly
  void _changeFont() {
    final random = Random();
    setState(() {
      _currentFont = _fonts[random.nextInt(_fonts.length)]();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 251),

      // Two buttons (Color + Font)
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _changeColor,
            backgroundColor: Colors.teal,
            child: const Icon(Icons.color_lens, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _changeFont,
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.font_download, color: Colors.white),
          ),
        ],
      ),

      body: Center(
        child: Container(
          width: 350,
          height: 550,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor, // dynamic background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  // Green Section (dynamic)
                  Container(
                    height: 200,
                    color: cardColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset('assets/images/logo.png', height: 86),
                        const SizedBox(height: 8),
                        Text(
                          'ISLAMIC UNIVERSITY OF TECHNOLOGY',
                          style: _currentFont.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),

                  // White Section
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 80, // space for overlapping photo
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            Icons.key,
                            'Student ID',
                            '210041242',
                            isHighlighted: true,
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                            Icons.person,
                            'Student Name',
                            'UMME HUNNY KHAN',
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                            Icons.school,
                            'Program',
                            'B.Sc. in CSE',
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.business, 'Department', 'CSE'),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                            Icons.location_on,
                            'Country',
                            'Bangladesh',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Footer
                  Text(
                    'A subsidiary organ of OIC',
                    style: _currentFont.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Photo Container (overlapping)
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 26, 53, 34),
                        width: 5,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/pfp.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable row builder
  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: _currentFont.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        Container(
          padding:
              isHighlighted
                  ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
                  : null,
          decoration:
              isHighlighted
                  ? BoxDecoration(
                    color: const Color.fromARGB(255, 22, 61, 35),
                    borderRadius: BorderRadius.circular(10),
                  )
                  : null,
          child: Text(
            value,
            style:
                isHighlighted
                    ? _currentFont.copyWith(color: Colors.white)
                    : _currentFont.copyWith(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

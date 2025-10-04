import 'dart:io';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IdCardScreen extends StatelessWidget {
  final String id, name, department, program, country;
  final File? imageFile; // mobile
  final XFile? webImageFile; // web

  const IdCardScreen({
    super.key,
    required this.id,
    required this.name,
    required this.department,
    required this.program,
    required this.country,
    this.imageFile,
    this.webImageFile,
  });

  @override
  Widget build(BuildContext context) {
    // Decide image based on platform
    ImageProvider? displayImage;
    if (kIsWeb && webImageFile != null) {
      displayImage = NetworkImage(webImageFile!.path);
    } else if (!kIsWeb && imageFile != null) {
      displayImage = FileImage(imageFile!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Student ID Card")),
      // Floating Reset button outside like previous buttons
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // go back to form
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.refresh, color: Colors.white),
        tooltip: "Reset Form",
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 550,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 21, 39, 24),
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
                  // Green section
                  Container(
                    height: 200,
                    color: const Color.fromARGB(255, 21, 39, 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset('assets/images/logo.png', height: 86),
                        const SizedBox(height: 8),
                        const Text(
                          'ISLAMIC UNIVERSITY OF TECHNOLOGY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // White section
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 80,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.key, 'Student ID', id, true),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.person, 'Name', name),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.school, 'Program', program),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                            Icons.business,
                            'Department',
                            department,
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.location_on, 'Country', country),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A subsidiary organ of OIC',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              // Photo Container
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
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child:
                          displayImage != null
                              ? Image(image: displayImage, fit: BoxFit.cover)
                              : Image.asset(
                                'assets/images/pfp.jpg',
                                fit: BoxFit.cover,
                              ),
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

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, [
    bool isHighlighted = false,
  ]) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
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
            style: TextStyle(
              color: isHighlighted ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

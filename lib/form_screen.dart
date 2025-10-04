import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'id_card_screen.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // for kIsWeb

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _programController = TextEditingController();
  final _departmentController = TextEditingController();
  final _countryController = TextEditingController();

  XFile? _pickedFile; // for mobile & web
  File? _imageFile; // only for mobile

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _pickedFile = picked;
        if (!kIsWeb) {
          _imageFile = File(picked.path); // only mobile
        }
      });
    }
  }

  void _generateIDCard() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => IdCardScreen(
                id: _idController.text,
                name: _nameController.text,
                program: _programController.text,
                department: _departmentController.text,
                country: _countryController.text,
                imageFile: _imageFile, // mobile
                webImageFile: _pickedFile, // web
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? displayImage;
    if (_pickedFile != null) {
      displayImage =
          kIsWeb
              ? NetworkImage(_pickedFile!.path) // web
              : FileImage(_imageFile!) as ImageProvider; // mobile
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Generate Student ID Card")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: "Student ID"),
                  validator: (value) => value!.isEmpty ? "Enter ID" : null,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) => value!.isEmpty ? "Enter Name" : null,
                ),
                TextFormField(
                  controller: _programController,
                  decoration: const InputDecoration(labelText: "Program"),
                  validator: (value) => value!.isEmpty ? "Enter Program" : null,
                ),
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(labelText: "Department"),
                  validator:
                      (value) => value!.isEmpty ? "Enter Department" : null,
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country"),
                  validator: (value) => value!.isEmpty ? "Enter Country" : null,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: displayImage,
                    child:
                        displayImage == null
                            ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.black54,
                            )
                            : null,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _generateIDCard,
                  child: const Text("Generate ID Card"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

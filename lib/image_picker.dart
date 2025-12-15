import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(home: ImagePickerExample()));
}

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({Key? key}) : super(key: key);

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();  // Ini ok, tapi pastikan package terinstall

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error: $e');  // Tambah logging untuk debug
      // Opsional: Tampilkan snackbar ke user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking photo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker Example")),
      body: Center(
        child: _imageFile == null
            ? const Text("Belum ada gambar")
            : Image.file(_imageFile!),  // Ok, karena check null di atas
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: _pickImageFromGallery,
            tooltip: 'Pilih dari Galeri',
            child: const Icon(Icons.photo),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "camera",
            onPressed: _pickImageFromCamera,
            tooltip: 'Ambil dari Kamera',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
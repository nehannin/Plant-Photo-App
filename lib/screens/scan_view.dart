import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';
import '../models/plant.dart';

import 'dart:io'; // For handling files on mobile
import 'dart:typed_data'; // For handling image data in web environments
import 'package:flutter/foundation.dart'; // For platform checking (mobile vs. web)

/// The `ScanView` screen allows the user to add a plant by selecting an image,
/// entering a name, and adding optional notes.
class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  Uint8List? _imageBytes; // Stores image data as bytes (for web usage)

  /// Displays a dialog allowing the user to choose between taking a photo
  /// with the camera or selecting an image from the gallery.
  Future<void> _showPickOptions() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context); // Close dialog after selection
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Choose from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context); // Close dialog after selection
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Handles image selection from the camera or gallery.
  /// Updates `_image` with the selected file and processes image bytes for web.
  void _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _imageBytes = null; // Reset the imageBytes when a new file is picked
      });

      if (_image?.path != null) {
        // If running on web, read the image as bytes
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageBytes = bytes;
          });
        }
      }
    }
  }

/// Saves the plant data into the provider.
/// Converts the image to bytes for web if necessary.
void _savePlant() async {
  Uint8List? imageBytes;
  if (kIsWeb && _image != null) {
    imageBytes = await _image!.readAsBytes();
  }

  // Create a new plant instance
  final plant = Plant(
    name: _nameController.text,
    photo: _image?.path ?? '', // Use file path for mobile
    dateAdded: DateTime.now(),
    notes: _notesController.text,
    photoBytes: imageBytes, // Save image as bytes for web compatibility
  );

  // Add the plant to the provider and navigate back
  Provider.of<PlantProvider>(context, listen: false).addPlant(plant);
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Plant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Plant Name'),
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),

            SizedBox(height: 20),

            // Display selected image or placeholder text
            _image == null
                ? Text('No image selected.')
                : (kIsWeb
                    ? _imageBytes == null
                        ? Text('No image selected.')
                        : Image.memory(_imageBytes!)
                    : Image.file(File(_image!.path))),

            SizedBox(height: 20),

            // Button to select an image
            ElevatedButton(
              onPressed: _showPickOptions, // Show image source options
              child: Text(_image == null ? 'Choose or Take Photo' : 'Change Photo'),
            ),

            SizedBox(height: 20),

            // Button to save the plant
            ElevatedButton(
              onPressed: _savePlant,
              child: Text('Save Plant'),
            ),
          ],
        ),
      ),
    );
  }
}

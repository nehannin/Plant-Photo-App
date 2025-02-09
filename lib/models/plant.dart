import 'dart:typed_data';

class Plant {
  String name; // The name of the plant
  String photo; // File path for the plant image (used on mobile)
  DateTime dateAdded; // The date when the plant was added
  String? notes; // Optional notes about the plant
  Uint8List? photoBytes; // Stores the image as bytes (used for web support)

  Plant({
    required this.name,
    required this.photo,
    required this.dateAdded,
    this.notes, // Notes are optional
    this.photoBytes, // Used only if the app runs on the web
  });
}

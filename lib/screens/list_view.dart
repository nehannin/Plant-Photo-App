import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart'; // Provider to manage plant data
import '../models/plant.dart'; // Plant model to store plant data
import 'scan_view.dart'; // Screen to add new plants
import 'dart:io'; // For handling file paths on mobile
import 'dart:typed_data'; // For image bytes handling on the web
import 'package:flutter/foundation.dart'; // For platform-specific checks
import 'package:intl/intl.dart'; // For date formatting

/// This is the ListView screen where the plants are displayed in a list.
class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plants')),

      // Consumer widget listens to changes in PlantProvider to rebuild the UI.
      body: Consumer<PlantProvider>(
        builder: (context, plantProvider, child) {
          return ListView.builder(
            itemCount: plantProvider.plants.length,
            itemBuilder: (context, index) {
              Plant plant = plantProvider.plants[index]; // Fetch the plant data

              return ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      plant.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Display the plant's image if available
                    plant.photo.isEmpty
                        ? Icon(Icons.photo, size: 150) // Placeholder if no image
                        : kIsWeb
                            // If it's a web platform, use photoBytes for the image
                            ? Image.memory(
                                plant.photoBytes!, // Use the bytes of the photo for web
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(plant.photo), // For mobile, display the image from the file path
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                    SizedBox(height: 16),

                    // Display the date when the plant was added, formatted as 'yyyy-MM-dd'
                    Text(
                      DateFormat('yyyy-MM-dd').format(plant.dateAdded),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Future functionality can go here to navigate to a detail view
                },
              );
            },
          );
        },
      ),

      // Floating action button to add a new plant by navigating to the ScanView screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScanView()), // Navigate to the ScanView for adding plants
          );
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantProvider with ChangeNotifier {
  final List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  void addPlant(Plant plant) {
    _plants.add(plant);
    notifyListeners();
  }
}

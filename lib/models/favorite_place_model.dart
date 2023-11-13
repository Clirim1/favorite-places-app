import 'dart:io';

class FavoritePlaceModel {
  String? title;
  String? description;
  double? latitude;
  double? longitude;
  File? imageFile;

  FavoritePlaceModel(
      {required this.title,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.imageFile});

  Future<Map<String, dynamic>> toJson() async {
    return {
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageFilePath': imageFile!.path,
    };
  }

  factory FavoritePlaceModel.fromJson(Map<String, dynamic> json) {
    return FavoritePlaceModel(
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      imageFile:
          json['imageFilePath'] != null ? File(json['imageFilePath']) : null,
    );
  }
}

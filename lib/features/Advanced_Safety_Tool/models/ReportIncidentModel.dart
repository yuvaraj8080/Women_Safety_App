import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class ReportIncidentModel {
  final String id;
  String title;
  String description;
  String type;
  String city;
  String fullName;
  String latitude;
  String longitude;
  String phoneNo;
  DateTime? time;

  ReportIncidentModel({
    required this.title,
    required this.id,
    required this.description,
    required this.type,
    required this.city,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.phoneNo,
    this.time,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo);
  String get formattedDateTime => TFormatter.formatDate(time);


  static ReportIncidentModel empty() => ReportIncidentModel(
    title:"",
    id: "",
    description: "",
    type: "",
    city: "",
    fullName: "",
    latitude:"",
    longitude:"",
    phoneNo: "",
  );

  Map<String, dynamic> toJson() {
    return {
      "Title":title,
      "Description": description,
      "Type": type,
      "City": city,
      "FullName": fullName,
      "PhoneNo": phoneNo,
      "Latitude": latitude,
      "Longitude": longitude,
      "Time": time,
    };
  }

  factory ReportIncidentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ReportIncidentModel(
        title:data["Title"]??'', // Add this line
        id: document.id,
        description: data["Description"] ?? '',
        type: data["Type"] ?? '',
        city: data["City"] ?? '',
        fullName: data["FullName"] ?? '',
        phoneNo: data["PhoneNo"] ?? '',
        latitude: data["Latitude"] ?? 0.0,
        longitude: data["Longitude"] ?? 0.0,
        time: data.containsKey('Time') ? data['Time']?.toDate() : null,
      );
    } else {
      return ReportIncidentModel.empty();
    }
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class ReportIncidentModel {
  final String id;
  String titleIncident;
  String categoriesIncident;
  String incidentCity;
  String incidentDescription;
  DateTime? incidentDate;
  List<String>? incidentImages;
  String fullName;
  String latitude;
  String longitude;
  String phoneNo;

  ReportIncidentModel({
    required this.id,
    required this.titleIncident,
    required this.categoriesIncident,
    required this.incidentCity,
    required this.incidentDescription,
    this.incidentDate,
    this.incidentImages,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.phoneNo,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo);
  String get formattedDateTime => TFormatter.formatDate(incidentDate);

  static ReportIncidentModel empty() => ReportIncidentModel(
    id: "",
    titleIncident: "",
    categoriesIncident: "",
    incidentCity: "",
    incidentDescription: "",
    fullName: "",
    latitude: "",
    longitude: "",
    phoneNo: "",
  );

  Map<String, dynamic> toJson() {
    return {
      "TitleIncident": titleIncident,
      "CategoriesIncident": categoriesIncident,
      "IncidentCity": incidentCity,
      "IncidentDescription": incidentDescription,
      "IncidentDate": incidentDate,
      "IncidentImages": incidentImages,
      "FullName": fullName,
      "Latitude": latitude,
      "Longitude": longitude,
      "PhoneNo": phoneNo,
    };
  }

  factory ReportIncidentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ReportIncidentModel(
        id: document.id,
        titleIncident: data["TitleIncident"] ?? '',
        categoriesIncident: data["CategoriesIncident"] ?? '',
        incidentCity: data["IncidentCity"] ?? '',
        incidentDescription: data["IncidentDescription"] ?? '',
        incidentDate: data.containsKey('IncidentDate') ? data['IncidentDate']?.toDate() : null,
        incidentImages: List<String>.from(data["IncidentImages"] ?? []),
        fullName: data["FullName"] ?? '',
        latitude: data["Latitude"] ?? '',
        longitude: data["Longitude"] ?? '',
        phoneNo: data["PhoneNo"] ?? '',
      );
    } else {
      return ReportIncidentModel.empty();
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class ReportIncidentModel {
  final String id;
  String description;
  String type;
  String city;
  String fullName;
  String liveLocation;
  String phoneNo;
  DateTime? time;

  ReportIncidentModel({
    required this.id,
    required this.description,
    required this.type,
    required this.city,
    required this.fullName,
    required this.liveLocation,
    required this.phoneNo,
    this.time,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo);

  static ReportIncidentModel empty() => ReportIncidentModel(
    id: "",
    description: "",
    type: "",
    city: "",
    fullName: "",
    liveLocation: "",
    phoneNo: "",
  );

  Map<String, dynamic> toJson() {
    return {
      "Description": description,
      "Type": type,
      "City": city,
      "FullName": fullName,
      "LiveLocation": liveLocation,
      "PhoneNo": phoneNo,
      "Time": time,
    };
  }

  factory ReportIncidentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ReportIncidentModel(
        id: document.id,
        description: data["Description"] ?? '',
        type: data["Type"] ?? '',
        city: data["City"] ?? '',
        fullName: data["FullName"] ?? '',
        liveLocation: data["LiveLocation"] ?? '',
        phoneNo: data["PhoneNo"] ?? '',
        time: data.containsKey('Time') ? data['Time']?.toDate() : null,

      );
    } else {
      return ReportIncidentModel.empty();
    }
  }
}
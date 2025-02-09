import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/features/SOS%20Help%20Screen/Google_Map/controller/LiveLocationController.dart';
import 'package:flutter_women_safety_app/utils/constants/image_string.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../../data/repositories/report_repository/report_repository.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/ReportIncidentModel.dart';

class ReportIncidentController extends GetxController {
  static ReportIncidentController get instance => Get.find();

  final reportRepository = Get.put(ReportIncidentRepository());
  final userController = Get.put(UserController());
  final locationController = Get.put(LiveLocationController());

  final loading = false.obs;
  DateTime? picked;
  Timestamp? deadlineDeadTimeStamp;

  final reportKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final incidentDate = TextEditingController();
  final incidentCity = TextEditingController();
  final RxString selectedIncident = ''.obs;
  final RxString categoryIncident = ''.obs;
  final RxList<String> specificIncidents = <String>[].obs;

  ///// SELECTED INCIDENT IMAGES ////
  final List<XFile> selectedImages = <XFile>[].obs;

  final popularIncidents = [
    'Harassment',
    'Sexual Harassment',
    'Stalking',
    'Domestic Violence',
    'Rape',
    'Attempt to Rape',
    'Molestation',
    'Human Trafficking',
    'Acid Attack',
    'Dowry Harassment',
    'Workplace Harassment',
    'Cyber Harassment',
    'Public Safety Violation',
    'Kidnapping & Abduction',
    'Eve-Teasing',
    'Forced Marriage',
    'Online Blackmail'
  ];

  final categorizedIncidents = {
    'Harassment': [
      'Verbal Harassment',
      'Physical Harassment',
      'Psychological Harassment',
      'Workplace Harassment',
      'Online Harassment'
    ],
    'Sexual Harassment': [
      'Unwanted Touching',
      'Catcalling & Lewd Remarks',
      'Indecent Exposure',
      'Groping',
      'Sexual Advances at Workplace'
    ],
    'Stalking': [
      'In-Person Stalking',
      'Cyber stalking',
      'Repeated Unwanted Contact',
      'Following & Monitoring'
    ],
    'Domestic Violence': [
      'Physical Abuse',
      'Emotional & Psychological Abuse',
      'Financial Control & Exploitation'
    ],
    'Rape': [
      'Stranger Rape',
      'Marital Rape',
      'Date Rape',
      'Gang Rape'
    ],
    'Molestation': [
      'Child Molestation',
      'Public Transport Molestation',
      'Crowd Molestation'
    ],
    'Cyber Harassment': [
      'Online Threats',
      'Revenge Porn',
      'Hate Speech & Trolling',
      'Doxxing'
    ],
    'Public Safety Violation': [
      'Harassment in Public Transport',
      'Unauthorized Filming & Voyeurism',
      'Drugging & Spiking of Drinks'
    ],
    'Kidnapping & Abduction': [
      'Forced Abduction',
      'Child Abduction',
      'Trafficking for Exploitation'
    ],
    'Dowry Harassment': [
      'Dowry Demands',
      'Emotional Blackmail for Dowry',
      'Dowry Deaths'
    ],
    'Forced Marriage': [
      'Child Marriage',
      'Honor-Based Forced Marriage',
      'Threatened or Coerced Marriage'
    ],
    'Online Blackmail' : [
      'Threats for Personal Content',
      'Financial Exploitation',
      'Blackmail Using Private Media'
    ],
  };

  List<String> incidentCities = [
    "Mumbai City", "Mumbai Suburban", "Thane", "Palghar", "Raigad", "Ratnagiri", "Sindhudurg",
    "Pune", "Kolhapur", "Sangli", "Satara", "Solapur",
    "Nashik", "Ahmednagar", "Dhule", "Jalgaon", "Nandurbar",
    "Aurangabad", "Beed", "Jalna", "Osmanabad", "Latur", "Parbhani", "Hingoli", "Nanded",
    "Amravati", "Akola", "Buldhana", "Washim", "Yavatmal",
    "Nagpur", "Bhandara", "Chandrapur", "Gadchiroli", "Gondia", "Wardha"
  ];

  void updateSpecificIncidents(String incident) {
    selectedIncident.value = incident;
    specificIncidents.value = categorizedIncidents[incident] ?? [];
  }

  void updateSubcategoryIncident(String incident) {
    categoryIncident.value = incident;
  }

  /// Function to pick multiple images from the gallery
  Future<void> pickMultipleImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  /// SAVE REPORT INCIDENT
  Future<void> createReportIncident() async {
    try {
      LocationData? locationData = await locationController.getCurrentLocation();

      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Wait For Incident Reporting", TImages.loadingLottie);

      /// CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// FORM VALIDATION
      if (!reportKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// MAP DATA
      final authUser = userController.user.value;

      if (locationData == null) {
        TLoaders.warningSnackBar(title: "Incident Report", message: "Turn on device location for report incident");
        TFullScreenLoader.stopLoading();
        return;
      }

      /// UPLOAD IMAGES TO FIREBASE STORAGE AND GET URLS
      List<String> imageUrls = await _uploadImagesToStorage();

      final newReportIncident = ReportIncidentModel(
        id: authUser.id,
        titleIncident: selectedIncident.value,
        categoriesIncident: categoryIncident.value,
        incidentCity: incidentCity.text.trim(),
        incidentDescription: description.text.trim(),
        incidentDate: picked,
        incidentImages: imageUrls,
        fullName: authUser.fullName,
        latitude: "${locationData.latitude}",
        longitude: "${locationData.longitude}",
        phoneNo: authUser.phoneNumber,
      );

      /// SAVE REPORT INCIDENT IN FIRESTORE
      await reportRepository.saveReportIncident(newReportIncident);

      /// RESET FIELDS
      resetFields();
      Get.back();

      /// REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // /// SHOW NOTIFICATION APP
      // showNotification(title:"She Shield",
      //   body:"Thanks for report, Every incident reported is a step closer to creating a world where every woman feels safe and empowered",
      // );

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: "Failed to save report incident: $e");
    }
  }

  /// UPLOAD IMAGES TO FIREBASE STORAGE
  Future<List<String>> _uploadImagesToStorage() async {
    List<String> imageUrls = [];
    for (XFile image in selectedImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("Incident Images")
          .child(userController.user.value.id)
          .child(fileName);
      await ref.putFile(File(image.path));
      String imageUrl = await ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  void resetFields() {
    description.clear();
    incidentDate.clear();
    incidentCity.clear();
    selectedIncident.value = '';
    categoryIncident.value = '';
    specificIncidents.clear();
    selectedImages.clear();
    loading(false);
  }
}
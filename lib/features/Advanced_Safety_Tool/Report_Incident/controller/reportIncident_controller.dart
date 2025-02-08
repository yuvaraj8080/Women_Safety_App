import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/features/SOS%20Help%20Screen/Google_Map/controller/LiveLocationController.dart';
import 'package:flutter_women_safety_app/utils/constants/image_string.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../../data/repositories/report_repository/report_repository.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/ReportIncidentModel.dart';

class ReportIncidentController extends GetxController {
  static ReportIncidentController get instance => Get.find();

  DateTime? picked;
  Timestamp? deadlineDeadTimeStamp;


  final loading = false.obs;
  final reportKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final title = TextEditingController();
  final city = TextEditingController();
  final type = TextEditingController();
  final reportDate = TextEditingController();
  final reportRepository = Get.put(ReportIncidentRepository());
  final userController = Get.put(UserController());

  ///// SELECTED INCIDENT IMAGES ////
  final List<XFile> selectedImages = <XFile>[].obs;


  final RxString selectedIncident = ''.obs;
  final RxList<String> specificIncidents = <String>[].obs;

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

  List<String> IncidentCity = [
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


  /// Function to pick multiple images from the gallery
  Future<void> pickMultipleImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  /// GETTING CURRENT LIVE LOCATION FROM THE MAP
   final locationController = Get.put(LiveLocationController());


  /// SAVE REPORT INCIDENT
  Future<void> createReportIncident() async {
    try {
     LocationData?  locationData = await locationController.getCurrentLocation();

      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Wait for reporting",TImages.loadingLottie);


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

      if(locationData == null){
        TLoaders.warningSnackBar(title:"Incident Report",message:"Turn on device location for report incident");
        TFullScreenLoader.stopLoading();
        return;
      }
      final newReportIncident = ReportIncidentModel(
        title:title.text.trim(),
        description: description.text.trim(),
        city: city.text.trim(),
        fullName:authUser.fullName,
        phoneNo:authUser.phoneNumber,
        time:DateTime.now(),
        type:type.text.trim(),
        id:authUser.id,
        latitude:"${locationData.latitude}",
        longitude:"${locationData.longitude}",
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

  void resetFields() {
    title.clear();
    description.clear();
    city.clear();
    loading(false);
  }
}
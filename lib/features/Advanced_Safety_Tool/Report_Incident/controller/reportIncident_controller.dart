import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/data/repositories/authentication/authentication-repository.dart';
import 'package:flutter_women_safety_app/data/repositories/user/user_repository.dart';
import 'package:flutter_women_safety_app/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../../data/repositories/report_repository/report_repository.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/ReportIncidentModel.dart';

class ReportIncidentController extends GetxController {
  static ReportIncidentController get instance => Get.find();

  final loading = false.obs;
  final reportKey = GlobalKey<FormState>();

  final description = TextEditingController();
  final city = TextEditingController();
  final liveLocation = TextEditingController();
  final type = TextEditingController();

  final reportRepository = Get.put(ReportIncidentRepository());
  final userController = Get.put(UserController());


  /// SAVE REPORT INCIDENT
  Future<void> createReportIncident() async {
    try {
      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Wating For Report",'');

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
      final newReportIncident = ReportIncidentModel(
        description: description.text.trim(),
        city: city.text.trim(),
        fullName:authUser.fullName,
        liveLocation: liveLocation.text.trim(),
        phoneNo:authUser.phoneNumber,
        time:DateTime.now(),
        type:type.text.trim(),
        id:authUser.id,
      );

      /// SAVE REPORT INCIDENT IN FIRESTORE
      await reportRepository.saveReportIncident(newReportIncident);

      /// RESET FIELDS
      resetFields();

      /// REMOVE LOADER
      TFullScreenLoader.stopLoading();

      /// SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(
          title: "Success", message: "Report incident saved successfully");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: "Failed to save report incident: $e");
    }
  }

  void resetFields() {
    description.clear();
    city.clear();
    liveLocation.clear();
    loading(false);
  }
}
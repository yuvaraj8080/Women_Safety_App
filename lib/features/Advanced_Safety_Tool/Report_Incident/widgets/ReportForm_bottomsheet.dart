import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/custom_shapes/container/TRoundedContainer.dart';
import 'package:flutter_women_safety_app/features/Advanced_Safety_Tool/Report_Incident/controller/reportIncident_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validator.dart';

class ReportCrimeIncidentScreen extends StatelessWidget {
  const ReportCrimeIncidentScreen({super.key});

  void pickPurchaseDate(BuildContext context) async {
    final controller = Get.put(ReportIncidentController());
    controller.picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Allow past dates from 2000
      lastDate: DateTime(2100),
      context: context,
    );
    if (controller.picked != null) {
      controller.reportDate.text = "${controller.picked!.day}/${controller.picked!.month}/${controller.picked!.year}";
      controller.deadlineDeadTimeStamp = Timestamp.fromMillisecondsSinceEpoch(controller.picked!.millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    final incidentController = Get.put(ReportIncidentController());
    return Scaffold(
      appBar:TAppBar(title:Text("Report Incident"),
        showBackArrow:true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical:10),
        child: SingleChildScrollView(
          child: Form(
            key: incidentController.reportKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Report Crime, Save Lives.", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: TSizes.size24),

                /// Popular Incidents Dropdown
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: "Select Report Incident",
                  ),
                  items: incidentController.popularIncidents.map((incident) {
                    return DropdownMenuItem(
                      value: incident,
                      child: Text(incident),
                    );
                  }).toList(),
                  onChanged: (value) {
                    incidentController.updateSpecificIncidents(value as String);
                  },
                  validator: (value) => TValidator.validateEmptyText("Popular Incident", value),
                ),

                const SizedBox(height: TSizes.size12),

                /// Specific Incidents Dropdown
                Obx(() {
                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Specific Incidents",
                    ),
                    items: incidentController.specificIncidents.map((specificIncident) {
                      return DropdownMenuItem(
                        value: specificIncident,
                        child: Text(specificIncident),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Handle specific incident selection if needed
                    },
                    validator: (value) => TValidator.validateEmptyText("Specific Incident", value),
                  );
                }),

                const SizedBox(height: TSizes.size12),

                /// City Dropdown
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: "City", prefixIcon: Icon(Iconsax.building)),
                  items: incidentController.IncidentCity.map((city) {
                    return DropdownMenuItem(
                      child: Text(city),
                      value: city,
                    );
                  }).toList(),
                  onChanged: (value) {
                    incidentController.city.text = value as String;
                  },
                  validator: (value) => TValidator.validateEmptyText("Incident City", value),
                ),


                const SizedBox(height: TSizes.size12),

                TextFormField(
                  controller: incidentController.description,
                  expands: false,
                  maxLines:4,
                  decoration: const InputDecoration(
                      hintText: "Incident description",),
                  validator: (value) => TValidator.validateEmptyText("incident description", value),
                ),

                const SizedBox(height: TSizes.size24),
                //// SELECT CRIME DATE & IMAGE FORM THE GALLERY ///
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) => TValidator.validateEmptyText("Purchased", value),
                        controller: incidentController.reportDate,
                        decoration: InputDecoration(
                          hintText: "Incident Date",
                          prefixIcon: IconButton(onPressed:()=>pickPurchaseDate(context), icon:const Icon(Icons.calendar_month,color:Colors.blue)),
                        ),
                      ),
                    ),
                    SizedBox(width: TSizes.size8),

                    // VENDOR NAME HARE
                    Expanded(
                      child:OutlinedButton(
                          onPressed: () => incidentController.pickMultipleImages(),
                          child:Text("Upload Images")
                      )
                    ),
                  ],
                ),


                const SizedBox(height: TSizes.size12),
                /// Display selected images in a GridView
                Obx(() {
                  if (incidentController.selectedImages.isEmpty) {
                    return SizedBox.shrink();
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing:TSizes.size16,
                        mainAxisSpacing:4
                      ),
                      itemCount: incidentController.selectedImages.length,
                      itemBuilder: (context, index) {
                        return
                        TRoundedContainer(
                          radius:20,showBorder:true,
                          child:Image.file(File(incidentController.selectedImages[index].path)),
                        );
                      },
                    );
                  }
                }),


                const SizedBox(height: 30),
                /// Submit Repo₹₹rt Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (incidentController.reportKey.currentState!.validate()) {
                            incidentController.createReportIncident();
                          }
                        },
                        child: const Text("Submit Report")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
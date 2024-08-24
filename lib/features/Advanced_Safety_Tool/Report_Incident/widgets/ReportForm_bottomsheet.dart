import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validator.dart';
import '../controller/reportIncident_controller.dart';

class IncidentReportBottomSheet extends StatelessWidget {
  final ReportIncidentController incidentController = Get.put(ReportIncidentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key:incidentController.reportKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Incident Report", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: TSizes.size24),
                TextFormField(
                  controller: incidentController.description,
                  expands: false,
                  maxLines: 2,
                  decoration: const InputDecoration(
                      labelText: "Incident description", prefixIcon: Icon(Iconsax.edit)),
                  validator: (value) => TValidator.validateEmptyText("incident description", value),
                ),
                const SizedBox(height: TSizes.size16),
                Row(
                  children: [
                    ///  Type Dropdown
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: "Type",),
                        items: incidentController.types.map((type) {
                          return DropdownMenuItem(
                            child: Text(type),
                            value: type,
                          );
                        }).toList(),
                        onChanged: (value) {
                          incidentController.type.text = value as String;
                        },
                        validator: (value) => TValidator.validateEmptyText("Incident Type", value),
                      ),
                    ),
                    const SizedBox(width: TSizes.size8),
                    /// City Dropdown
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "City", prefixIcon: Icon(Iconsax.building)),
                        items: incidentController.cities.map((city) {
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
                    ),
                  ],
                ),
                const SizedBox(height:30),
                /// Sign Up Button Create Account button
                SizedBox(width:double.infinity,
                    child:ElevatedButton(onPressed:(){incidentController.createReportIncident();},
                        child:const Text("Submit Report")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
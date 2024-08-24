import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validator.dart';

class IncidentReportBottomSheet extends StatefulWidget {
  @override
  _IncidentReportBottomSheetState createState() => _IncidentReportBottomSheetState();
}

class _IncidentReportBottomSheetState extends State<IncidentReportBottomSheet> {
  String? _selectedType;
  String? _selectedCity;

  List<String> _types = ['Harassment', 'Rape', 'Abuse', "Others"];
  List<String> _cities = ['Mumbai', 'Pune', 'Delhi', 'Nashik'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Incident Report", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: TSizes.size24),
              TextFormField(
                expands: false,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: "Incident description", prefixIcon: Icon(Iconsax.edit)),
                validator: (value) => TValidator.validateEmptyText("description", value),
              ),
              const SizedBox(height: TSizes.size16),
              Row(
                children: [
                  ///  Type Dropdown
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Type",),
                      items: _types.map((type) {
                        return DropdownMenuItem(
                          child: Text(type),
                          value: type,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      validator: (value) => TValidator.validateEmptyText("Incident Type", value),
                    ),
                  ),
                  const SizedBox(width: TSizes.size8),
                  /// City Dropdown
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "City", prefixIcon: Icon(Iconsax.building)),
                      items: _cities.map((city) {
                        return DropdownMenuItem(
                          child: Text(city),
                          value: city,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value;
                        });
                      },
                      validator: (value) => TValidator.validateEmptyText("Incident City", value),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height:30),
          
              /// Sign Up Button Create Account button
              SizedBox(width:double.infinity,
                  child:ElevatedButton(
                      onPressed:(){},
                      child:const Text("Submit Report")))
            ],
          ),
        ),
      ),
    );
  }
}
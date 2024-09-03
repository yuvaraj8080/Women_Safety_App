import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  final String city;
  final String description;
  final String fullName;
  
  final String phoneNo;
  final DateTime time;
  final String type;

  const ReportWidget({
    Key? key,
    required this.city,
    required this.description,
    required this.fullName,
  
    required this.phoneNo,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('City: $city', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Type: $type'),
            SizedBox(height: 8.0),
            Text('Reported by: $fullName'),
            SizedBox(height: 8.0),
            Text('Description: $description'),
            SizedBox(height: 8.0),
           // Text('Location: $latitude, $longitude'),
            SizedBox(height: 8.0),
            Text('Phone: $phoneNo'),
            SizedBox(height: 8.0),
            Text('Time: ${time.toLocal()}'),
          ],
        ),
      ),
    );
  }
}

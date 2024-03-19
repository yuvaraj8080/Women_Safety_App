import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TAppBar(title:Text("Help"),showBackArrow:true,),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Help_Card(title: 'App Info',leading:Icon(Icons.info),subtitle:"About this she Shield app", onPressed: (){}),
            Help_Card(title: 'Terms and Privacy Policy',leading:Icon(Icons.file_copy),subtitle:"", onPressed: (){}),
            // Help_Card(title: 'Contact us',leading:Icon(Icons.help_center),subtitle:"8080737803, 9321759433", onPressed: (){}),
            Card(
              child:ListTile(
                title:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Us",style:Theme.of(context).textTheme.headlineSmall),
                    Text("Give your feedback to regarding app and share your Safety App Experience.",style:Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height:4),
                    Text("Yuvaraj Dekhane: 8080737803",style:Theme.of(context).textTheme.bodySmall),
                    Text("Niraj Chalke : 9321759433",style:Theme.of(context).textTheme.bodySmall),
                    Text("Pallavi Bandarkar : 9867740565",style:Theme.of(context).textTheme.bodySmall),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}

class Help_Card extends StatelessWidget {
  const Help_Card({
    super.key, required this.title, required this.subtitle, required this.leading,required this.onPressed,
  });
  final VoidCallback onPressed;
  final String title,subtitle;
  final Icon leading;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:Text(title,style:Theme.of(context).textTheme.titleMedium),
        subtitle:Text(subtitle,style:Theme.of(context).textTheme.bodyMedium),
        leading:leading,
        onTap:onPressed,
      ),
    );
  }
}

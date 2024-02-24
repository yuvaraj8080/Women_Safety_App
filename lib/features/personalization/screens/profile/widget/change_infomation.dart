
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../../../../utils/update_name_controller.dart';
import '../../../../../utils/validators/validator.dart';

class ChangeInformationScreen extends StatelessWidget {
  const ChangeInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      ///CUSTOM APPBAR
        appBar:TAppBar(
          showBackArrow:true,
          title:Text("Update Your Profile",style:Theme.of(context).textTheme.headlineSmall),
        ),
        body: Padding(padding:const EdgeInsets.all(10),
            child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  ///HEADING
                  Text("use real name and identity for easy verification. this identity will appear on several pages.",
                    style:Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height:8),

                  /// TEXT FIELD AND BUTTON
                  Form(
                      key:controller.updateUserNameFormKey,
                      child:Column(
                          children:[
                            TextFormField(
                              controller: controller.userName,
                              validator:(value) => TValidator.validateEmptyText("First name", value),
                              expands: false,
                              decoration: const InputDecoration(labelText:"Username",prefixIcon:Icon(Iconsax.user)),
                            ),
                          ]
                      )),
                  const SizedBox(height: 8),

                  /// SAVE BUTTON
                  SizedBox(
                    width:double.infinity,
                    child:ElevatedButton(onPressed:()=>  controller.updateUserName(),
                        child:const Text("Save")),
                  )
                ]
            )
        )
    );
  }
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/validators/validator.dart';
import '../../../controllers/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title:const Text("Re-Authenticate User")),
      body: SingleChildScrollView(
        child:Padding(
          padding:const EdgeInsets.all(8),
          child:Form(
            key:controller.reAuthFormKey,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  ///EMAIL A
                  TextFormField(
                    controller:controller.verifyEmail,
                    validator:TValidator.validateEmail,
                    decoration:const InputDecoration(
                      prefixIcon:Icon(Iconsax.direct_right),labelText:"Enter E-Mail"),
                  ),
                  const SizedBox(height:8),

                  ///  PASSWORD
                  Obx(() => TextFormField(
                    obscureText:controller.hidePassword.value,
                    controller:controller.verifyPassword,
                    validator:(value)=> TValidator.validateEmptyText("Password", value),
                    decoration: InputDecoration(
                      labelText:"Enter Password",
                      prefixIcon:const Icon(Iconsax.password_check),
                      suffixIcon:IconButton(
                        onPressed:()=>controller.hidePassword.value = !controller.hidePassword.value,
                        icon:const Icon(Iconsax.eye_slash),
                      )
                    )
                  )),
                  const SizedBox(height:8),

              /// LOGIN BUTTON
              SizedBox(
                width:double.infinity,
                child:ElevatedButton(onPressed:()=>controller.reAuthenticateEmailAndPasswordUser(),child:const Text("Verify")),
          )
            ])
          )
        )
      )
    );
  }
}

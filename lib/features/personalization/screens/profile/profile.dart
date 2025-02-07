
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/features/personalization/screens/profile/widget/change_infomation.dart';
import 'package:flutter_women_safety_app/features/personalization/screens/profile/widget/change_name.dart';
import 'package:flutter_women_safety_app/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../../../common/widgets.Login_Signup/images/t_circular_image.dart';
import '../../../../common/widgets.Login_Signup/texts/section_heading.dart';
import '../../../../utils/shimmer_circular_Indicator/shimmer.dart';
import '../../controllers/user_controller.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar:const TAppBar(showBackArrow:true,title:Text("Profile")),

      ///------BODY-------
      body:SingleChildScrollView(
        child:Padding(padding:const EdgeInsets.all(20),
        child:Column(
          children:[

            ///-----PROFILE PICTURE--------k
            SizedBox(
              width:double.infinity,
              child:Column(
                  children:[
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty? networkImage :"assets/user/UserImge.png";
                      return controller.imageUploading.value
                      ? const TShimmerEffect(width:80, height: 80)
                      :TCircularImage(image:image,width:100,height:100,isNetworkImage:networkImage.isNotEmpty,fit:BoxFit.cover);

                    }),
                TextButton(onPressed:() => controller.uploadUserProfilePicture(), child:const Text("Change Profile Picture"))
              ])
            ),

            ///------DETAIL--------
            const Divider(),
            const SizedBox(height:5),
            const TSectionHeading(title:"Profile Information",showActionButton:false),
            const SizedBox(height:8),

            TProfileMenu(title:"Name",value:controller.user.value.fullName,onPressed:()=>Get.to(()=>const ChangeName())),
            TProfileMenu(title:"Username",value:controller.user.value.username,onPressed:()=>Get.to(()=> const ChangeInformationScreen())),

             ///-----HEADING PERSONAL INFORMATION-------

            const TSectionHeading(title:"Personal Information",showActionButton:false),
            const SizedBox(height:8),

            TProfileMenu(title:"User ID", value:controller.user.value.id,icon:Iconsax.copy,onPressed:(){}),
            TProfileMenu(title:"E-Mail", value:controller.user.value.email,onPressed:(){}),
            TProfileMenu(title:"Phone NO:", value:controller.user.value.phoneNumber,onPressed:(){}),
            const Divider(),
            const SizedBox(height:10),
            Center(child: TextButton(
              onPressed:() => controller.deleteAccountWarningPopup(),child:const Text("Close Account",style:TextStyle(color:Colors.red)),
            ))
          ]
        )
        )
      )
    );
  }
}



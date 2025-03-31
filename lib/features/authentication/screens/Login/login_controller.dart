
  import 'package:flutter/cupertino.dart';
  import 'package:get/get.dart';
  import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../../data/repositories/authentication/authentication-repository.dart';
import '../../../../utils/Storage/hive_storage.dart' show THiveStorage;
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';

  class LoginController extends GetxController{

    /// VARIABLES

    final rememberMe  = false.obs;
    final hidePassword  = true.obs;
    final storage = THiveStorage.instance();
    final email = TextEditingController();
    final password = TextEditingController();
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final userController = Get.put(UserController());


    @override
    void onInit(){
      email.text = storage.readData("REMEMBER_ME_EMAIL")??'';
      password.text = storage.readData("REMEMBER_ME_PASSWORD")??'';
      super.onInit();
    }

    ///EMAIL AND PASSWORD SIGN IN
    Future<void> emailAndPasswordSignIn () async{
      try{
        //  START LOADING
        TFullScreenLoader.openLoadingDialog("Login For you...",TImages.loadingLottie);

        // CHECK INTERNET CONNECTIVITY
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }


        //  FORM VALIDATION

        if(!loginFormKey.currentState!.validate()){
          TFullScreenLoader.stopLoading();
        }


        //SAVE DATE IF REMEMBER ME IS SELECTED

        if(rememberMe.value){
          storage.saveData("REMEMBER_ME_EMAIL",email.text.trim());
          storage.saveData("REMEMBER_ME_PASSWORD",password.text.trim());
        }

        // LOGIN USER EMAIL & PASSWORD AUTHENTICATION
        final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(),password.text.trim());


        //REMOVE LOADER

        TFullScreenLoader.stopLoading();

        // REDIRECT
        AuthenticationRepository.instance.screenRedirect();
      }catch(e){
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
      }
    }



    ///GOOGLE SIGN IN AUTHENTICATION
    Future<void> googleSignIn() async{
      try{
        // START LOADING
        TFullScreenLoader.openLoadingDialog("Sign In For you....",TImages.loadingLottie);

        //CHECK INTERNET CONNECTIVITY
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

        // GOOGLE AUTHENTICATION
        final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

        //SAVE USER RECORD
        await userController.saveUserRecord(userCredentials);

        // REMOVE LOADER
        TFullScreenLoader.stopLoading();

        // REDIRECT
        AuthenticationRepository.instance.screenRedirect();

      }
      catch(e){
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title:"Oh Snap", message:e.toString());
      }
    }

  }
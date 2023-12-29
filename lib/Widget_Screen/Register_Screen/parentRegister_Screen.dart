
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Componants_Widget/custom_Button.dart';
import '../../Componants_Widget/custom_textfield.dart';
import '../../Constants/Constants.dart';
import '../Login_Screen.dart';
class RegisterParent extends StatefulWidget {

  @override
  State<RegisterParent> createState() => _RegisterParentState();
}
class _RegisterParentState extends State<RegisterParent> {


  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formData["password"].toString()!= _formData["repassword"].toString()) {
        dialogueBox(context, "both password should be same");
      }
      else {
        progressIndicator(context);
        try {
          FirebaseAuth auth = FirebaseAuth.instance;
          auth.createUserWithEmailAndPassword(
              email: _formData["email"].toString(),
              password: _formData["password"].toString()).whenComplete(() =>
              goTo(context,Login()));
        }
        on FirebaseAuthException catch (e) {
          dialogueBox(context, e.toString());
        }
        catch (e) {
          dialogueBox(context, e.toString());
        }
      }
      print('Email: ${_formData["email"]}'); // Simulating backend call
      print('Password: ${_formData["password"]}');

      // Backend validation and authentication process here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Register Parent",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff000000),
                Color(0x88434343),
                Color(0xff000000),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
            child: Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.name,
                    hintText: "Enter name",
                    prefix:Icon(Icons.person,color:Colors.blueAccent,),
                    onsave:(name){
                      _formData["name"] = name??"";
                    },
                    validate:(name){
                      if(name!.isEmpty){
                        return "name is Required";
                      }
                      else if(name.length<=3){
                        return "Enter a strong name";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.number,
                    hintText: "Enter mobile number ",
                    // isPassword:isPasswordShown,
                    prefix:Icon(Icons.phone,
                      color:Colors.blueAccent,),
                    onsave:(mobile){
                      _formData["mobile"] = mobile??"";
                    },

                    validate:(mobile){
                      if(mobile!.isEmpty){
                        return "Mobile number is Required";
                      }
                      else if(mobile.length<=9 || mobile.length>=11){
                        return "Enter a valid mobile number";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                      textInputAction:TextInputAction.next,
                      keyboardtype:TextInputType.emailAddress,
                      hintText: "Enter Email",prefix:Icon(Icons.email,
                      color:Colors.blueAccent),
                      onsave:(email){
                        _formData["email"] = email??"";
                      },
                      validate:(email){
                        if(email!.isEmpty){
                          return "Enter a valid Email";
                        }
                        else if(email.length<5){
                          return "Enter Correct Email";
                        }
                        else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
                          return "Enter correct email missing '@'";
                        }
                        else{
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                      textInputAction:TextInputAction.next,
                      keyboardtype:TextInputType.emailAddress,
                      hintText: "Enter child email",prefix:Icon(Icons.email,
                      color:Colors.blueAccent),
                      onsave:(cemail){
                        _formData["cemail"] = cemail??"";
                      },
                      validate:(gemail){
                        if(gemail!.isEmpty){
                          return "Enter a valid Email";
                        }
                        else if(gemail.length<5){
                          return "Enter a correct Email";
                        }
                        else if(  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(gemail)){
                          return "Enter correct email missing '@'";
                        }
                        else{
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.emailAddress,
                    hintText: "Enter Password",
                    isPassword:isPasswordShown,
                    prefix:Icon(Icons.key_outlined,
                      color:Colors.blueAccent,),

                    onsave:(password){
                      _formData["password"] = password??"";
                    },

                    validate:(password){
                      if(password!.isEmpty){
                        return "Password is Required";
                      }
                      else if(password.length<6){
                        return "create a strong Password";
                      }
                      else{
                        return null;
                      }
                    },
                    suffix:IconButton(onPressed: (){
                      setState((){
                        isPasswordShown =! isPasswordShown;
                      });
                    },
                      icon:isPasswordShown
                          ?Icon(Icons.visibility_off,color: Colors.blueAccent)
                          :Icon(Icons.visibility,color:Colors.blueAccent),
                    ),

                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.emailAddress,
                    hintText: "retype Password",
                    isPassword:isPasswordShown,
                    prefix:Icon(Icons.key_outlined,
                      color:Colors.blueAccent,),
                    onsave:(repassword){
                      _formData["repassword"] = repassword??"";
                    },

                    validate:(repassword){
                      if(repassword!.isEmpty){
                        return "Password is Required";
                      }
                      else if(repassword.length<6){
                        return "create a strong Password";
                      }
                      else{
                        return null;
                      }
                    },
                    suffix:IconButton(onPressed: (){
                      setState((){
                        isPasswordShown =! isPasswordShown;
                      });
                    },
                      icon:isPasswordShown
                          ?Icon(Icons.visibility_off,color: Colors.blueAccent)
                          :Icon(Icons.visibility,color:Colors.blueAccent),
                    ),

                  ),
                  SizedBox(height: 35),
                  CustomElevatedButton(
                    title: "Register",
                    onPressed: () {
                      if(_formKey.currentState!.validate());
                      _onSubmit();
                    },
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder:(context){
                        return Login();
                      }));
                    },
                    child: Text(
                      "Login with your Account",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset:false,
    );
  }
}

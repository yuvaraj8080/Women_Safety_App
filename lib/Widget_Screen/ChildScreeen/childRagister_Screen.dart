import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Componants_Widget/customText_Button.dart';
import 'package:flutter_women_safety_app/Constants/Constants.dart';
import 'package:flutter_women_safety_app/Constants/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Componants_Widget/customElevated_Button.dart';
import '../../Componants_Widget/custom_textfield.dart';
import 'Child_Login_Screen.dart';
import '../ParentScreen/ParentHome_Screen.dart';
class RagisterChild extends StatefulWidget {

  @override
  State<RagisterChild> createState() => _RagisterChildState();
}
class _RagisterChildState extends State<RagisterChild> {


  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();

  _onSubmit()async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formData["password"].toString()!= _formData["repassword"].toString()) {
        dialogueBox(context, "both password should be same");
      }
      else {
        progressIndicator(context);
        try {
          setState(() {
            isLoading  = true;
          });
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _formData["cemail"].toString(),
              password: _formData["password"].toString()
          );
          if(userCredential.user != null){
            setState((){
              isLoading = true;
            });
            final v= userCredential.user!.uid;
            DocumentReference<Map<String,dynamic>>db=
            FirebaseFirestore.instance.collection("user").doc(v);
            final user = UserModel(
                name:_formData["name"].toString(),
                phone:_formData["phone"].toString(),
                childEmail:_formData["cemail"].toString(),
                guardianEmail:_formData["gemail"].toString(),
                id:v,
              type:"child",
            );
            final jsonData = user.toJson();
            await db.set(jsonData).whenComplete((){
              goTo(context,Login());
              setState(() {
                isLoading = false;
              });
            });
          }
        }
        on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            dialogueBox(context,'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            dialogueBox(context,'The account already exists for that email.');
          }
        }
        catch (e) {
          setState(() {
            isLoading = false;
          });
          dialogueBox(context,e.toString());
          print(e);
        }
      }
      print('Email: ${_formData["cemail"]}'); // Simulating backend call
      print('Password: ${_formData["password"]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Register child",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent.shade700,
      ),
      body: Stack(
        children: [
          isLoading
          ?progressIndicator(context)
          :SingleChildScrollView(
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
                        prefix:Icon(Icons.person,color:Colors.pinkAccent,),
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
                        prefix:Icon(Icons.phone,
                          color:Colors.pinkAccent,),
                        onsave:(phone){
                          _formData["phone"] = phone??"";
                        },

                        validate:(phone){
                          if(phone!.isEmpty){
                            return "mobile number is required";
                          }
                          else if(phone.length<=9 || phone.length>=11){
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
                          color:Colors.pinkAccent),
                          onsave:(cemail){
                            _formData["cemail"] = cemail??"";
                          },
                          validate:(cemail){
                            if(cemail!.isEmpty){
                              return "Enter a valid Email";
                            }
                            else if(cemail.length<5){
                              return "Enter Correct Email";
                            }
                            else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(cemail)){
                              return "Enter a correct email missing '@'";
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
                          hintText: "Enter Guardian Email",prefix:Icon(Icons.email,
                          color:Colors.pinkAccent),
                          onsave:(gemail){
                            _formData["gemail"] = gemail??"";
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
                          color:Colors.pinkAccent,),

                        onsave:(password){
                          _formData["password"] = password??"";
                        },

                        validate:(password){
                          if(password!.isEmpty){
                            return "Password is required";
                          }
                          else if(password.length<6){
                            return "Create a strong password";
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
                              ?Icon(Icons.visibility_off,color: Colors.pinkAccent)
                              :Icon(Icons.visibility,color:Colors.pinkAccent),
                        ),

                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        textInputAction:TextInputAction.next,
                        keyboardtype:TextInputType.emailAddress,
                        hintText: "retype Password",
                        isPassword:isRetypePasswordShown,
                        prefix:Icon(Icons.key_outlined,
                          color:Colors.pinkAccent,),
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
                            isRetypePasswordShown =! isRetypePasswordShown;
                          });
                        },
                          icon:isRetypePasswordShown
                              ?Icon(Icons.visibility_off,color: Colors.pinkAccent)
                              :Icon(Icons.visibility,color:Colors.pinkAccent),
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
                      customTextButton(title: "Login with your Account",
                    onPressed:(){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
                        return Login();
                      }));
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset:false,
    );
  }
}

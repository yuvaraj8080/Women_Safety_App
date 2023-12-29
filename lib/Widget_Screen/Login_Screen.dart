import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Componants_Widget/custom_textfield.dart';
import 'package:flutter_women_safety_app/Widget_Screen/Register_Screen/parentRegister_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Componants_Widget/custom_Button.dart';
import 'Register_Screen/childRagister_Screen.dart';


class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: ${_formData["email"]}'); // Simulating backend call
      // Encrypt and securely store passwords in production
      print('Password: ${_formData["password"]}');
      // Backend validation and authentication process here
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " User Login",
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
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
            child: Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.emailAddress,
                    hintText: "Enter Email",prefix:Icon(Icons.email_outlined,
                      color:Colors.blueAccent),
                    onsave:(email){
                      _formData["email"] = email??"";
                    },
                    validate:(email){
                      if(email!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
                        return "Enter a valid Email";
                      }
                      else if(email.length<5){
                        return "Enter valid Email";
                      }
                      else if(!email.contains('@')){
                        return "Enter Correct Email missing @";
                      }
                      else{
                        return null;
                      }
                    }
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    textInputAction:TextInputAction.next,
                    keyboardtype:TextInputType.emailAddress,
                    hintText: "Enter Password",isPassword:isPasswordShown,
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
                  SizedBox(height: 35),
                  CustomElevatedButton(
                    title: "Login",
                    onPressed: () {
                      if(_formKey.currentState!.validate());
                      _onSubmit();
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: Text(
                          "Forget Password",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: TextButton(
                          child: Text(
                            "Click here",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder:(context){
                        return RagisterChild();
                      }));
                    },
                    child: Container(
                      color:Colors.white38,
                      height:45,width:double.infinity,
                      child: Card(elevation:3,shadowColor:Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left:80,top:6),
                          child: Text(
                            "Register as Child",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder:(context){
                        return RegisterParent();
                      }));
                    },
                    child: Container(
                      color:Colors.white38,
                      height:45,width:double.infinity,
                      child: Card(elevation:3,shadowColor:Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left:80,top:6),
                          child: Text(
                            "Register as Parent",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
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

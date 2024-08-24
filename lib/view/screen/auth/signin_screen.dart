import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:play_tv/data/model/request/login_request_model.dart';
import 'package:play_tv/data/model/request/manual_login_request_model.dart';
import 'package:play_tv/localization/language_constrants.dart';
import 'package:play_tv/provider/auth_provider.dart';
import 'package:play_tv/util/authentication/authentication.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/custom_themes.dart';
import 'package:play_tv/util/images.dart';
import 'package:play_tv/view/baseWidgets/customScaffoldMessenger.dart';
import 'package:play_tv/view/baseWidgets/textfield/custom_password_textfield.dart';
import 'package:play_tv/view/baseWidgets/textfield/comment_textfield.dart';
import 'package:play_tv/view/screen/auth/registration_screen.dart';
import 'package:provider/provider.dart';

import '../../baseWidgets/button/custom_button.dart';
import '../../baseWidgets/button/signin_button.dart';
import '../../baseWidgets/customWidgets/custom_button.dart';
import '../../baseWidgets/customWidgets/custom_textField.dart';
import '../mainScreen/main_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  List<String> socialIconList = [
    Images.google_logo_png,
    // Images.facebook_logo
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode loginButtonFocusNode = FocusNode();
  FocusNode registerButtonFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    loginButtonFocusNode.dispose();
    registerButtonFocusNode.dispose();
    super.dispose();
  }

  @override
  //Google Login Function
  _validateGoogle(BuildContext context) async {
    await Authentication.signInWithGoogle(context: context).then((value) async {
      LoginRequestModel loginRequestModel = LoginRequestModel(
          userName: value?.displayName ?? "",
          email: value?.email ?? "",
          socialTokenId: value?.uid ?? "",
          socialType: "G");
      await Provider.of<AuthProvider>(context, listen: false)
          .login(loginRequestModel, (bool status, String msg) {
        if (status) {
          showSnackNotification(msg, context: context, isError: !status);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        } else {
          showSnackNotification(msg, context: context, isError: !status);
        }
      }, context);
    });
  }

  //Manual Login Function

  _manualLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      String email = _email.text.trim();
      String password = _password.text.trim();

      if (email.isEmpty) {
        showSnackNotification("Email is required", context: context);
      } else if (password.isEmpty) {
        showSnackNotification("Password is required", context: context);
      } else {
        ManualLoginRequestModel request =
            ManualLoginRequestModel(email: email, password: password);
        Provider.of<AuthProvider>(context, listen: false).manualLogin(request,
            (bool status, String msg) {
          if (status) {
            showSnackNotification(context: context, isError: !status, msg);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          } else {
            showSnackNotification(context: context, isError: !status, msg);
          }
        }, context);
      }
    }
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: ColorResources.getDeepForestBrown(context),
        body: FocusWatcher(
          child: Container(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.1, vertical: height * 0.04),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Image.asset(Images.tv_logo_png),
                    Container(
                      width: width - 70,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.white,

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: _formKey,
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          autofocus: true,
                          onKey: (RawKeyEvent event) {
                            print("hassan+${event.logicalKey}");
                            if (event is RawKeyDownEvent) {
                              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                                print("arrow down");
                                if (_emailFocusNode.hasFocus) {
                                  print("2");
                                  _passwordFocusNode.requestFocus();
                                } else if (_passwordFocusNode.hasFocus) {
                                  print("3");
                                  loginButtonFocusNode.requestFocus();
                                } else if (loginButtonFocusNode.hasFocus) {
                                  print("3");
                                  registerButtonFocusNode.requestFocus();
                                } else if (registerButtonFocusNode.hasFocus) {
                                  print("4");
                                  _emailFocusNode.requestFocus();
                                } else {
                                  print("5");
                                  _emailFocusNode.requestFocus();
                                }
                              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                                print("arrow up");
                                if (_emailFocusNode.hasFocus) {
                                  print("1");
                                  FocusScope.of(context).requestFocus(registerButtonFocusNode);
                                } else if (_passwordFocusNode.hasFocus) {
                                  print("2");
                                  _emailFocusNode.requestFocus();
                                } else if (loginButtonFocusNode.hasFocus) {
                                  print("3");
                                  _passwordFocusNode.requestFocus();
                                } else if (registerButtonFocusNode.hasFocus) {
                                  print("4");
                                  loginButtonFocusNode.requestFocus();
                                } else {
                                  print("5");
                                  FocusScope.of(context).requestFocus(_emailFocusNode);
                                }
                              } else if (event.logicalKey == LogicalKeyboardKey.select) {
                                print("enter");
                                // Handle Enter key press (e.g., trigger login or register)
                                if (_emailFocusNode.hasFocus) {
                                  _passwordFocusNode.requestFocus();
                                } else if (_passwordFocusNode.hasFocus) {
                                  loginButtonFocusNode.requestFocus(); // Implement your login logic
                                } else if (loginButtonFocusNode.hasFocus) {
                                  _manualLogin();
                                } else if (registerButtonFocusNode.hasFocus) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen())); // Implement your register logic
                                }else{
                                  _manualLogin();
                                }
                              }
                            }
                          },
                          child: Column(
                            children: [

                              CustomFormField(
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                controller: _email,
                                text: "Email",
                                hintText: "Enter Your Email",
                              ),
                              // TextFormField(
                              //   controller: _password,
                              //   focusNode: _passwordFocusNode ,
                              //   onFieldSubmitted: (value){
                              //     FocusScope.of(context).requestFocus(loginButtonFocusNode);
                              //
                              //   },
                              //   decoration: InputDecoration(
                              //     helperText: "Pasword"
                              //   ),
                              // ),

                              CustomPasswordTextField(
                                focusNode: _passwordFocusNode,
                             nextNode: loginButtonFocusNode,
                             //   textInputAction: TextInputAction.go,
                                controller: _password,
                                title: "Password",
                                hintTxt: "Enter Your Password",
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forget Password",
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    )),
                              ),
                              Provider.of<AuthProvider>(context).isLoginLoading
                                  ? CircularProgressIndicator()
                                  : CustomFormButton(
                                      focusNode: loginButtonFocusNode,
                                      textColor: Colors.white,
                                      bgColor: ColorResources.PRIMARY_COLOR,
                                      btnText: getTranslated('login', context),
                                      onTap: () {
                                        _manualLogin();
                                      },
                                    ),
                              Text(
                                getTranslated('create_new_account', context),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: ColorResources.WHITE),
                              ),
                              CustomFormButton(
                                focusNode: registerButtonFocusNode,
                                textColor: ColorResources.WHITE,
                                bgColor: ColorResources.PRIMARY_COLOR,
                                btnText: getTranslated("signup", context),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                              ),
                              Text(getTranslated("login_with", context),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: ColorResources.WHITE)),
                              Provider.of<AuthProvider>(context).isLoading
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.1),
                                      child: CircularProgressIndicator())
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                          socialIconList.length,
                                          (index) => Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: index == 0
                                                      ? () async {
                                                          _validateGoogle(context);
                                                        }
                                                      //TODO: FaceBook Implementation
                                                      : null,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        ColorResources.GREY,
                                                    child: index == 0
                                                        ? Image.asset(
                                                            socialIconList[index],
                                                            width: 35,
                                                          )
                                                        : SvgPicture.asset(
                                                            socialIconList[index],
                                                            width: 35,
                                                          ),
                                                    radius: 30,
                                                  ),
                                                ),
                                              )),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: robotoRegular.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24),
                                      children: [
                                        TextSpan(
                                            text: getTranslated(
                                                'login_footer_one', context),
                                            style: robotoRegular.copyWith(
                                                color: ColorResources.WHITE,
                                                fontSize: 22)),
                                        TextSpan(
                                            text: getTranslated(
                                                'login_footer_two', context),
                                            style: robotoRegular.copyWith(
                                                color: ColorResources.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22)),
                                        TextSpan(
                                            text: getTranslated(
                                                'login_footer_three', context),
                                            style: robotoRegular.copyWith(
                                                color: ColorResources.WHITE,
                                                fontSize: 22)),
                                        TextSpan(
                                            text: getTranslated(
                                                'login_footer_four', context),
                                            style: robotoRegular.copyWith(
                                                color: ColorResources.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24))
                                      ]))
                            ],
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
      );
  }
}

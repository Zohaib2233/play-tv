import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:play_tv/data/model/request/register_request_model.dart';
import 'package:play_tv/provider/auth_provider.dart';
import 'package:play_tv/view/baseWidgets/textfield/custom_password_textfield.dart';
import 'package:play_tv/view/screen/auth/signin_screen.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../../util/images.dart';
import '../../baseWidgets/customScaffoldMessenger.dart';
import '../../baseWidgets/customWidgets/custom_button.dart';
import '../../baseWidgets/customWidgets/custom_textField.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  FocusNode _registerFocusNode = FocusNode();
  FocusNode _loginFocusNode = FocusNode();
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _loginFocusNode.dispose();
    _registerFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  _validate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      String username = _userName.text.trim();
      String email = _email.text.trim();
      String password = _password.text.trim();
      String confirmPassword = _confirmPassword.text.trim();

      if (username.isEmpty) {
        showSnackNotification("Username is required", context: context);
      } else if (username.length <= 4 || username.length > 9) {
        showSnackNotification("Username must be between 4 and 9 characters",
            context: context);
      } else if (email.isEmpty) {
        showSnackNotification("Email is required", context: context);
      } else if (!isValidEmail(email)) {
        showSnackNotification("Email is not valid", context: context);
      } else if (password.isEmpty) {
        showSnackNotification("Password is required", context: context);
      } else if (password.length < 6) {
        showSnackNotification("Password must be 6 characters",
            context: context);
      } else if (confirmPassword.isEmpty) {
        showSnackNotification("Confirm Password is required", context: context);
      } else if (password != confirmPassword) {
        showSnackNotification("Password do not match", context: context);
      } else {
        RegisterRequestModel request = RegisterRequestModel(
            socialType: "M",
            email: email,
            userName: username,
            password: password);
        Provider.of<AuthProvider>(context, listen: false).register(request,
            (bool status, String msg) {
          if (status) {
            showSnackNotification(context: context, isError: !status, msg);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SigninScreen()));
          } else {
            showSnackNotification(context: context, isError: !status, msg);
          }
        }, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: ColorResources.getDeepForestBrown(context),
          body: FocusWatcher(
            child: Form(
              key: _formKey,
              child: Container(
                  width: width,
                  height: height,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.04),
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(children: [
                            Image.asset(Images.tv_logo_png),
                            Container(
                              width: width - 70,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                autofocus: true,
                                onKey: (RawKeyEvent event) {
                                  print("hassan+${event.logicalKey}");
                                  if (event is RawKeyDownEvent) {
                                    if (event.logicalKey ==
                                        LogicalKeyboardKey.arrowDown) {
                                      print("arrow down");
                                      if (_emailFocusNode.hasFocus) {
                                        print("2");
                                        _passwordFocusNode.requestFocus();
                                      } else if (_passwordFocusNode.hasFocus) {
                                        print("3");
                                        _confirmPasswordFocusNode.requestFocus();
                                      } else if (_confirmPasswordFocusNode
                                          .hasFocus) {
                                        print("3");
                                        _registerFocusNode.requestFocus();
                                      } else if (_registerFocusNode.hasFocus) {
                                        print("4");
                                        _loginFocusNode.requestFocus();
                                      }
                                      else if (_usernameFocusNode.hasFocus) {
                                        print("6");
                                        _emailFocusNode.requestFocus();
                                      }
                                      else {
                                        print("5");
                                        _usernameFocusNode.requestFocus();
                                      }
                                    } else if (event.logicalKey ==
                                        LogicalKeyboardKey.arrowUp) {
                                      print("arrow up");
                                      if (_emailFocusNode.hasFocus) {
                                        print("1");
                                        FocusScope.of(context)
                                            .requestFocus(_usernameFocusNode);
                                      } else if (_passwordFocusNode.hasFocus) {
                                        print("2");
                                        _emailFocusNode.requestFocus();
                                      } else if (_confirmPasswordFocusNode
                                          .hasFocus) {
                                        print("3");
                                        _passwordFocusNode.requestFocus();
                                      } else if (_usernameFocusNode.hasFocus) {
                                        print("4");
                                        _loginFocusNode.requestFocus();
                                      } else if (_loginFocusNode.hasFocus) {
                                        _registerFocusNode.requestFocus();
                                      } else if (_registerFocusNode.hasFocus) {
                                        _confirmPasswordFocusNode.requestFocus();
                                      } else {
                                        print("5");
                                        _usernameFocusNode.requestFocus();
                                      }
                                    } else if (event.logicalKey ==
                                        LogicalKeyboardKey.select) {
                                      print("enter");
                                      // Handle Enter key press (e.g., trigger login or register)
                                      if (_emailFocusNode.hasFocus) {
                                        _passwordFocusNode.requestFocus();
                                      } else if (_passwordFocusNode.hasFocus) {
                                        _confirmPasswordFocusNode
                                            .requestFocus(); // Implement your login logic
                                      } else if (_confirmPasswordFocusNode
                                          .hasFocus) {
                                        _registerFocusNode.requestFocus();
                                      } else if (_registerFocusNode.hasFocus) {
                                        _validate();
                                      } else if (_usernameFocusNode.hasFocus) {
                                        _emailFocusNode.requestFocus();
                                      } else if (_loginFocusNode.hasFocus) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SigninScreen())); // Implement your register logic
                                      } else {
                                        _validate();
                                      }
                                    }
                                  }
                                },
                                child: Column(
                                  children: [
                                    CustomFormField(
                                      focusNode: _usernameFocusNode,
                                      textInputAction: TextInputAction.next,
                                      controller: _userName,
                                      text: "Username",
                                      hintText: "Enter Your Username",
                                    ),
                                    CustomFormField(
                                      focusNode: _emailFocusNode,
                                      textInputAction: TextInputAction.next,
                                      controller: _email,
                                      text: "Email",
                                      hintText: "Enter Your Email",
                                    ),
                                    CustomPasswordTextField(
                                      focusNode: _passwordFocusNode,
                                      nextNode: _confirmPasswordFocusNode,
                                      textInputAction: TextInputAction.next,
                                      controller: _password,
                                      title: "Password",
                                      hintTxt: "Enter Your Password",
                                    ),
                                    CustomPasswordTextField(
                                      focusNode: _confirmPasswordFocusNode,
                                      nextNode: _registerFocusNode,
                                      textInputAction: TextInputAction.done,
                                      controller: _confirmPassword,
                                      title: "Retype Password",
                                      hintTxt: "Enter Your Password Again",
                                    ),

                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: robotoRegular.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24),
                                            children: [
                                              TextSpan(
                                                  text: getTranslated(
                                                      'login_footer_one',
                                                      context),
                                                  style: robotoRegular.copyWith(
                                                      color: ColorResources.WHITE,
                                                      fontSize: 22)),
                                              TextSpan(
                                                  text: getTranslated(
                                                      'login_footer_two',
                                                      context),
                                                  style: robotoRegular.copyWith(
                                                      color: ColorResources
                                                          .PRIMARY_COLOR,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 22)),
                                              TextSpan(
                                                  text: getTranslated(
                                                      'login_footer_three',
                                                      context),
                                                  style: robotoRegular.copyWith(
                                                      color: ColorResources.WHITE,
                                                      fontSize: 22)),
                                              TextSpan(
                                                  text: getTranslated(
                                                      'login_footer_four',
                                                      context),
                                                  style: robotoRegular.copyWith(
                                                      color: ColorResources
                                                          .PRIMARY_COLOR,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 24))
                                            ])),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Provider.of<AuthProvider>(context)
                                            .isRegisterLoading
                                        ? CircularProgressIndicator()
                                        : CustomFormButton(
                                            focusNode: _registerFocusNode,
                                            textColor: Colors.white,
                                            bgColor: ColorResources.PRIMARY_COLOR,
                                            btnText:
                                                getTranslated('signup', context),
                                            onTap: () {
                                              _validate();
                                            },
                                          ),
                                    Text(
                                      getTranslated(
                                          "already_have_account", context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: ColorResources.WHITE),
                                    ),
                                    CustomFormButton(
                                      focusNode: _loginFocusNode,
                                      textColor: ColorResources.WHITE,
                                      bgColor: ColorResources.PRIMARY_COLOR,
                                      btnText: getTranslated('login', context),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SigninScreen()));
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ])))),
            ),
          )),
    );
  }
}

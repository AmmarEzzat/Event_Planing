import 'package:evently/auth/login/login_screen.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/home_screen/home_screen.dart';
import '../../utils/app_Colors.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController(text: "ammar@gmail.com");
  var nameController = TextEditingController(text: " ammar");
  var passwordController = TextEditingController(text: "123456");
  var rePasswordController = TextEditingController(text: "123456");
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var languageprovider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),

        centerTitle: true,
        title: Text("Register", style: AppStyles.semi24Primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.Logo),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  prefixIcon: Image.asset(
                    AppAssets.iconsUser01,
                    color: AppColors.gryColor,
                  ),
                  hintText: AppLocalizations.of(context)!.name,
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Email";
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return "Please Enter Valid Email ";
                    }

                    return null;
                  },

                  prefixIcon: Icon(Icons.email, color: AppColors.gryColor),
                  hintText: AppLocalizations.of(context)!.email,
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.lock, color: AppColors.gryColor),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.password,
                  obscuretext: false,
                  maxLines: 1,
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Password";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 chars";
                    }

                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Icons.lock, color: AppColors.gryColor),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.rePassword,
                  obscuretext: false,
                  maxLines: 1,
                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter re-Password";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 chars";
                    }
                    if (text != passwordController.text) {
                      return " Re-Password doesn`t match  password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.createAccount,
                  onbuttonClicked: () {
                    register(context);
                  },
                ),
                SizedBox(height: height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: AppStyles.semi16black,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginScreen.route);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: AppStyles.bold16Primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: "Loading");

      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        MyUser myUser = MyUser(
          name: nameController.text,
          email: emailController.text,
          id: credential.user?.uid ?? "",
        );
        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Register Successfuly",
          title: "Success",
          posActionName: "Ok",
          posAction: () {
            Navigator.of(context).pushNamed(HomeScreen.route);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: "The password provided is too weak.",
            title: "Error",
            posActionName: "Ok",
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: "The account already exists for that email.",
            title: "Error",
            posActionName: "Ok",
          );
        } else if (e.code == "network-request-failed") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message:
                " Network error (such as timeout,interrupted connection or unreachable host)has occurred,",
            title: "Error",
            posActionName: "Ok",
          );

          print("The supplied auth credential is incorrect,");
        } else if (e.code == "invalid-credential") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: " The supplied auth credential is incorrect,",
            title: "Error",
            posActionName: "Ok",
          );

          print("The supplied auth credential is incorrect,");
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          posActionName: "Ok",
        );
        print(e);
      }
    }
  }
}

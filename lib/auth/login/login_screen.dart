import 'package:evently/auth/forget_password/forget_password.dart';
import 'package:evently/auth/register/register_screen.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "Login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: "ammar@gmail.com");

  var passwordController = TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var languageprovider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.Logo,
                  filterQuality: FilterQuality.high,
                  height: height * 0.32,
                ),
                SizedBox(height: height * 0.02),
                Card(

                  borderOnForeground: true,

                  elevation: 10,
                  shadowColor: AppColors.primaryLight,
                  margin: EdgeInsetsGeometry.symmetric(
                    vertical: height * 0.03,
                    horizontal: width * 0.03,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),

                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.02,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          labelStyle: TextStyle(color: AppColors.blackColor),

                          borderColor: AppColors.gryColor,
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.gryColor,
                          ),
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Please Enter Email";
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(text);
                            if (!emailValid) {
                              return "Please Enter Email Valid";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextField(
                          obscuretext: false,
                          borderColor: AppColors.gryColor,
                          hintText: AppLocalizations.of(context)!.password,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.gryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: AppColors.gryColor,
                          ),

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
                        SizedBox(height: height * 0.01),

                        InkWell(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(ForgetPassword.route);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassword,
                            textAlign: TextAlign.end,
                            style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        CustomElevatedButton(
                          onbuttonClicked: () {
                            login();
                          },
                          backgroundColor: AppColors.primaryLight,
                          text: AppLocalizations.of(context)!.login,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dontHaveAccount,
                              style: AppStyles.semi16black,
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(RegisterScreen.route);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.createAccount,
                                style: AppStyles.bold16Primary.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryLight,
                                thickness: 2,
                                endIndent: 25,
                                indent: 15,
                              ),
                            ),

                            Text(
                              AppLocalizations.of(context)!.or,
                              style: AppStyles.semi16Primary,
                            ),

                            Expanded(
                              child: Divider(
                                endIndent: 15,
                                indent: 25,
                                thickness: 2,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomElevatedButton(
                          onbuttonClicked: () {
                            // todo:with google
                          },
                          text: AppLocalizations.of(context)!.loginWithGoogle,
                          backgroundColor: AppColors.whiteColor,
                          stylebutton: AppStyles.semi16Primary,
                          preffixIcobbutton: Image.asset(
                            AppAssets.iconsGoogle,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: "Waiting...");

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? "",
        );
        if (user == null) {
          return;
        }

        //عرفنا الprovider هنا عشان function login بره الbuild  وطالما هنعرف الprovider بره الbuild لازم نبعت الlisten false
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: " Login successfully",
          title: "Success",
          posActionName: "Ok",
          posAction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
          },
        );

        print(" login successfully");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: " No user found for that email.",
            title: "Error",
            posActionName: "Ok",
          );

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: " Wrong password provided for that user.",
            title: "Error",
            posActionName: "Ok",
          );

          print('Wrong password provided for that user.');
        } else if (e.code == "invalid-credential") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: " The supplied auth credential is incorrect,",
            title: "Error",
            posActionName: "Ok",
          );

          print("The supplied auth credential is incorrect,");
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
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          posActionName: "Ok",
        );

        print(e.toString());
      }
    }
  }
}

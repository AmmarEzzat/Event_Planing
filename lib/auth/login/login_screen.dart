import 'package:evently/auth/forget_password/forget_password.dart';
import 'package:evently/auth/register/register_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "Login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageprovider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.Logo,
                filterQuality: FilterQuality.high,
                height: height * 0.32,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                labelStyle: TextStyle(color: AppColors.blackColor),
          
                borderColor: AppColors.gryColor,
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(Icons.email, color: AppColors.gryColor),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
             obscuretext: false,
                borderColor: AppColors.gryColor,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.lock, color: AppColors.gryColor),
                suffixIcon: Icon(Icons.visibility_off, color: AppColors.gryColor),
              ),
              SizedBox(height: height * 0.01),
          
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ForgetPassword.route);

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
                onbuttonClicked: (){
                  Navigator.of(context).pushNamed(HomeScreen.route);
          
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
                     Navigator.of(context).pushNamed(RegisterScreen.route,);
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
          onbuttonClicked: (){
          
            // todo:with google
          
          },
                text: AppLocalizations.of(context)!.loginWithGoogle,
                backgroundColor: AppColors.whiteColor,
                stylebutton: AppStyles.semi16Primary,
                preffixIcobbutton: Image.asset(AppAssets.iconsGoogle,filterQuality: FilterQuality.high,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

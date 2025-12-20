import 'package:evently/auth/login/login_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_Colors.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = "RegisterScreen";

  const RegisterScreen({super.key});

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
          child: Column(
            children: [
              Image.asset(AppAssets.Logo),
              SizedBox(height: height * 0.02),

              CustomTextField(
                prefixIcon: Image.asset(
                  AppAssets.iconsUser01,
                  color: AppColors.gryColor,
                ),
                hintText: AppLocalizations.of(context)!.name,
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                prefixIcon: Icon(Icons.email, color: AppColors.gryColor),
                hintText: AppLocalizations.of(context)!.email,
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                prefixIcon: Icon(Icons.lock, color: AppColors.gryColor),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: AppLocalizations.of(context)!.password,
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                prefixIcon: Icon(Icons.lock, color: AppColors.gryColor),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: AppLocalizations.of(context)!.rePassword,
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(text: AppLocalizations.of(context)!.createAccount, onbuttonClicked: (){

                //create account
              }),
              SizedBox(height: height * 0.02),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(AppLocalizations.of(context)!.alreadyHaveAccount,style: AppStyles.semi16black,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
                      },
                      child: Text(AppLocalizations.of(context)!.login,style: AppStyles.bold16Primary,)
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

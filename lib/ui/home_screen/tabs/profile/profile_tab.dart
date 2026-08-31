import 'package:evently/auth/login/login_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/sign_in_with_google.dart';

import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/language_bottom_sheet.dart';
import 'package:evently/ui/home_screen/theme_bottom_sheet.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  static const String route = "ProfileTab";

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageprovider = Provider.of<AppLanguageProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    var themeprovider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;


    return Column(
      children: [
        Container(

          padding: EdgeInsets.only(top: height * 0.07, bottom: width * 0.03,),
          height: height * 0.25,

          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),


          ),
          child: Row(

            children: [

              CircleAvatar(
                  radius: width * 0.2,

                  backgroundColor: AppColors.primaryLight,

                  child: Image.asset(
                    AppAssets.route, filterQuality: FilterQuality.high,
                  )

              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userProvider.currentUser?.name ?? "", style: AppStyles.bold24white),

                      Text(userProvider.currentUser?.email ?? "", style: AppStyles.bold24white),
                    ]


                ),
              ),


            ],

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(AppLocalizations.of(context)!.language,
                style: AppStyles.bold20black,),


              SizedBox(height: height * 0.02),

              InkWell(
                onTap: () {
                  ShowLanguageBottomSheet();
                },

                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryLight, width: 2
                      ),

                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(


                            languageprovider.appLanguage == "en" ?
                            AppLocalizations.of(context)!.english :
                            AppLocalizations.of(context)!.arabic
                            , style: AppStyles.bold20Primary),

                        Icon(Icons.arrow_drop_down_sharp,
                          color: AppColors.primaryLight, size: 38,)
                      ],


                    )

                ),
              ),


              SizedBox(height: height * 0.02),

              Text(AppLocalizations.of(context)!.theme,
                style: AppStyles.bold20black,),


              SizedBox(height: height * 0.02),

              InkWell(
                onTap: () {
                  ShowThemeBottomSheet();
                },

                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryLight, width: 2
                      ),

                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(


                            themeprovider.appTheme == ThemeMode.light ?

                            (AppLocalizations.of(context)!.light) :
                            (AppLocalizations.of(context)!.dark)
                            , style: AppStyles.bold20Primary),

                        Icon(Icons.arrow_drop_down_sharp,
                          color: AppColors.primaryLight, size: 38,)
                      ],


                    )

                ),
              ),

            ],


          ),
        ),
        Spacer(),


        Padding(padding:
        EdgeInsetsGeometry.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.04

        ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(

                backgroundColor: AppColors.redColor,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadiusGeometry.circular(20)

                )
            ),
            onPressed: () {
              logout();
              eventListProvider.filterEventList = [];
              Navigator.of(context).pushReplacementNamed(LoginScreen.route);
            },
            child: Row(
              spacing: 6,
              children: [


                Icon(Icons.logout, color: AppColors.whiteColor, size: 25,),

                Text(AppLocalizations.of(context)!.logout,
                  style: AppStyles.semi20white,)
              ],
            ),
          ),)


      ],
    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet(
      context: context, builder: (context) => LanguageBottomSheet(),);
  }

  void ShowThemeBottomSheet() {
    showModalBottomSheet(
      context: context, builder: (context) => ThemeBottomSheet(),);
  }
  static Future <void> logout () async{

    final firebaseAuth=FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
  }

}

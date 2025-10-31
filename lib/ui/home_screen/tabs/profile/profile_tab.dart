import 'package:evently/l10n/app_localizations.dart';

import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home_screen/language_bottom_sheet.dart';
import 'package:evently/ui/home_screen/theme_bottom_sheet.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  static const String route ="ProfileTab";

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageprovider=Provider.of<AppLanguageProvider>(context);
    var themeprovider=Provider.of<AppThemeProvider>(context);
    var height=MediaQuery.of(context).size.height;
    return Scaffold(

appBar:  AppBar(

  backgroundColor: AppColors.primaryLight,


),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppLocalizations.of(context)!.language,style: AppStyles.bold20black,),


SizedBox(height:height*0.02),

          InkWell(
            onTap: (){
              ShowLanguageBottomSheet();


            },

            child: Container(
            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryLight,width: 2
                ),

              ),

                child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(


                        languageprovider.appLanguage=="en"?
                            AppLocalizations.of(context)!.english:
                        AppLocalizations.of(context)!.arabic
                        ,style:AppStyles.bold20Primary),

                    Icon(Icons.arrow_drop_down_sharp,color: AppColors.primaryLight,size: 38,)
                  ],


                )

            ),
          ),


            SizedBox(height:height*0.02),

            Text(AppLocalizations.of(context)!.theme,style: AppStyles.bold20black,),


            SizedBox(height:height*0.02),

            InkWell(
              onTap: (){
                ShowThemeBottomSheet();


              },

              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryLight,width: 2
                    ),

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(


                          themeprovider.appTheme==ThemeMode.light?

                          (AppLocalizations.of(context)!.light):
                         ( AppLocalizations.of(context)!.dark)
                          ,style:AppStyles.bold20Primary),

                      Icon(Icons.arrow_drop_down_sharp,color: AppColors.primaryLight,size: 38,)
                    ],


                  )

              ),
            ),

          ],


        ),
      ),

    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet(context: context, builder:(context) => LanguageBottomSheet(), );

  }

  void ShowThemeBottomSheet() {
 showModalBottomSheet(context: context, builder: (context)=> ThemeBottomSheet(),);


  }

}

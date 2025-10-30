import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;

    var languageprovider=Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [


          InkWell(

            onTap: (){

              languageprovider.changeLanguage("en");

            },
            child:
languageprovider.appLanguage=="en"?
    getSelectedItemWidget(AppLocalizations.of(context)!.english):
    getUnSelectedItemWidget(AppLocalizations.of(context)!.english)
    
          ),
          SizedBox(height: height*0.02),

          InkWell(
              onTap: (){

                languageprovider.changeLanguage("ar");
              },

              child:languageprovider.appLanguage=="ar"?
                  getSelectedItemWidget(AppLocalizations.of(context)!.arabic):
                  getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic)
          )
        ],

      ),
    );
  }
  Widget getSelectedItemWidget(String text){


   return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(text,style: AppStyles.bold20Primary,),

        Icon(Icons.check,color: AppColors.primaryLight,size: 25,),
      ],

    );

  }

Widget getUnSelectedItemWidget(String text){

return Text(text,style: AppStyles.bold20black,);
}
}

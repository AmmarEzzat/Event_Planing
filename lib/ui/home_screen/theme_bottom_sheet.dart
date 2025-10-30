import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;

    var themeprovider=Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [


          InkWell(

            onTap: (){

              themeprovider.changeTheme(ThemeMode.light);

            },
            child:
            themeprovider.appTheme==ThemeMode.light?
    getSelectedItemWidget(AppLocalizations.of(context)!.light):
    getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
    
          ),
          SizedBox(height: height*0.02),

          InkWell(
              onTap: (){

              themeprovider.changeTheme(ThemeMode.dark);
              },

              child:themeprovider.appTheme==ThemeMode.dark?
                  getSelectedItemWidget(AppLocalizations.of(context)!.dark):
                  getUnSelectedItemWidget(AppLocalizations.of(context)!.dark)
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

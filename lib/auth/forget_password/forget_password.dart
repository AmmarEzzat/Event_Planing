import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  static const String route = "ForgetPassword";

  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: AppStyles.bold20Primary,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: height * 0.03,
              horizontal: width * 0.09,
            ),
            child: Image.asset(
              AppAssets.ChangeSetting,
              filterQuality: FilterQuality.high,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomElevatedButton(
              text: AppLocalizations.of(context)!.resetPassword,
              onbuttonClicked: () {},
            ),
          ),
        ],
      ),
    );
  }
}

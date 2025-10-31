import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_screen/tabs/home/home_tab.dart';
import 'package:evently/ui/home_screen/tabs/love/Favorite_Tab.dart';
import 'package:evently/ui/home_screen/tabs/map/Map_Tab.dart';
import 'package:evently/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs=[HomeTab(),MapTab(),FavoriteTab(),ProfileTab()];
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      Theme(
        data: Theme.of(
          context,
        ).copyWith(canvasColor:AppColors.transparentColor),
        child:
        BottomAppBar(padding: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          notchMargin: 3,shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex=index;
              setState(() {

              });
            },

            items: [
              buildBottomNabItems(
                index: 0,


                iconSelectedName: AppAssets.HomeSelected,
                iconName: AppAssets.iconsHome,
                label: AppLocalizations.of(context)!.home,
              ),
              buildBottomNabItems(
                index:1,
                iconSelectedName: AppAssets.MapPinSelected,
                iconName: AppAssets.iconsMapPin,
                label: AppLocalizations.of(context)!.map,
              ),
              buildBottomNabItems(
                index: 2,
                iconSelectedName: AppAssets.HeartSelected,
                iconName: AppAssets.iconsHeart,
                label: AppLocalizations.of(context)!.love,
              ),
              buildBottomNabItems(
                index: 3,
                iconSelectedName: AppAssets.UserSelected,
                iconName: AppAssets.iconsUser01,
                label: AppLocalizations.of(context)!.profile,


              ),

            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        //navigate to add event screen
        //add event

      },
      child: Icon(Icons.add ,color: AppColors.whiteColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNabItems({
    required int index,
    required String iconSelectedName,
    required String label,
required String iconName,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(selectedIndex==index?iconSelectedName:iconName)),

      label: label,
    );
  }
}

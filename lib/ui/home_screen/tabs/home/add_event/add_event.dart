import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:evently/ui/widget/choose_date_or_time.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_Colors.dart';

class AddEvent extends StatefulWidget {
  static const String route = "AddEvent";

  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var formkey = GlobalKey<FormState>();
  int selectedIndex = 0;
  String formatedDate=""; //save date;
  DateTime? selectedDate  ;
  TimeOfDay? selectedTime;//save time;
  String formatedTime="";
var titleController=TextEditingController(); //save title;
var descriptionController=TextEditingController(); //save description;
  String selectedImage="";
  String selectedEvent="sport";



  @override
  Widget build(BuildContext context) {
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> imageSelectedNameList = [
      AppAssets.EventSport1,
      AppAssets.EventBirthday1,
      AppAssets.EventMeeting1,
      AppAssets.EventGaming1,
      AppAssets.EventWorkshop,
      AppAssets.EventBookclub1,
      AppAssets.EventExhibition1,
      AppAssets.EventHoliday1,
      AppAssets.EventEating1,
    ];
    selectedImage=imageSelectedNameList[selectedIndex];//save images ;
    selectedEvent=eventsNameList[selectedIndex];//save events ;
 // print("selectedEvent $selectedEvent");
 // print("selectedImage $selectedImage");
    // List<String>iconSelectedNameList=[
    //
    //   AppAssets.iconsBike,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //
    //
    // ];
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var languageprovider = Provider.of<AppLanguageProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.createevent,
          style: AppStyles.bold20Primary,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.009,
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  selectedImage,
                  height: height * 0.24,
                ),
              ),
            ),

            Container(
              height: height * 00.08,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    radius: 1,
                    onTap: () {
                      selectedIndex = index;


                      setState(() {});
                    },
                    child: TabEventWidget(
                      isSelected: selectedIndex == index,

                      eventName: eventsNameList[index],
                      backgroundColor: AppColors.primaryLight,
                      borderColor: AppColors.primaryLight,
                      textSelectedStyle: AppStyles.semi16white,
                      textUnSelectedStyle: AppStyles.semi16Primary,
                    ),
                  );
                },
                itemCount: eventsNameList.length,
              ),
            ),
            Form(

                key: formkey,
                child: Column(


                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        AppLocalizations.of(context)!.title,
                        style: AppStyles.semi16black,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomTextField(
                        controller: titleController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return
   AppLocalizations.of(context)!.pleaseentereventtitle;

                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.eventTitle,
                        style: AppStyles.semi16grey,
                        prefixIcon: Image.asset(AppAssets.Iconnoteedit),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(

                        AppLocalizations.of(context)!.description,
                        style: AppStyles.semi16black,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: descriptionController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return
                              AppLocalizations.of(context)!.pleaseentereventdescription;

                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!
                            .eventDescription,
                        style: AppStyles.semi16grey,
                        maxLines: 4,

                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),

                      child: ChooseDateOrTime(
                        iconName: AppAssets.IconDate,
                        eventDateOrTime: AppLocalizations.of(context)!
                            .eventDate,
                        onChooseDateOrTimeClicked: chooseDate,
                        chooseDateOrTime: selectedDate == null   ?
                             AppLocalizations.of(context)!.chooseDate
                            : formatedDate,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),

                      child: ChooseDateOrTime(
                        iconName: AppAssets.IconTime,
                        eventDateOrTime: AppLocalizations.of(context)!
                            .eventTime,
                        onChooseDateOrTimeClicked: chooseTime,
                        chooseDateOrTime: selectedTime==null ? AppLocalizations.of(context)!
                            .chooseTime:formatedTime,
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: AppStyles.semi16black,
                      ),
                    ),

                    InkWell(

                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                          horizontal: width * 0.02,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01,

                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                              color: AppColors.primaryLight, width: 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.02,
                                vertical: height * 0.01,
                              ),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.primaryLight,
                              ),
                              child: Image.asset(AppAssets.iconsLocationChoose),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              AppLocalizations.of(context)!.chooseEventLocation,
                              style: AppStyles.semi16Primary,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 25,
                              color: AppColors.primaryLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),

                    Container(margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.002),
                      child: CustomElevatedButton(
                        text: AppLocalizations.of(context)!.addEvent,
                        backgroundColor: AppColors.primaryLight,
                        onbuttonClicked: addEvent,
                      ),
                    ),
                    SizedBox(height: height * 0.01,)
                  ],)),
            SizedBox(height: height * 0.05),

          ],
        ),
      ),
    );
  }

  void addEvent() {
    if (formkey.currentState?.validate() == true) {

    }
  }

  void chooseDate()async {
  var choosedate= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
setState(() {
  selectedDate=choosedate;


});
  formatedDate=DateFormat("dd/MM/yyyy").format(selectedDate!);
        }

  void chooseTime() async{
    var chooseTime=await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    setState(() {
      selectedTime=chooseTime;
    });
    formatedTime=selectedTime!.format(context);



  }



}

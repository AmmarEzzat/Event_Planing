import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/ui/home_screen/tabs/home/add_event/pick_location_screen.dart';
import 'package:evently/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:evently/ui/widget/choose_date_or_time.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  String formatedDate = ""; //save date;
  DateTime? selectedDate;

  TimeOfDay? selectedTime; //save time;
  String formatedTime = "";
  var titleController = TextEditingController(); //save title;
  var descriptionController = TextEditingController(); //save description;
  String selectedImage = "";
  String selectedEvent = "";
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);

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
    selectedImage =
        imageSelectedNameList[eventListProvider.Selectedindex]; //save images ;
    selectedEvent = eventListProvider
        .eventsNameList[eventListProvider.Selectedindex]; //save events ;
    // print("selectedEvent $selectedEvent");
    // print("selectedImage $selectedImage");
    //     List<String>iconSelectedNameList=[
    //
    //       AppAssets.iconsBike,
    //      AppAssets.iconsCake,
    //       AppAssets.iconsCake,
    //       AppAssets.iconsCake,
    //       AppAssets.iconsCake,
    //       AppAssets.iconsCake,
    //       AppAssets.iconsCake,
    //      AppAssets.iconsCake,
    //      AppAssets.iconsCake,
    //
    //
    //     ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageprovider = Provider.of<AppLanguageProvider>(context);
   var provider=Provider.of<LocationProvider>(context);
var userProvider=Provider.of<UserProvider>(context);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.createevent,
          style: AppStyles.bold20Primary,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.009,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(selectedImage, height: height * 0.24),
              ),

              Container(
                height: height * 00.08,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      radius: 1,
                      onTap: () {
                        eventListProvider.changeSelectedEvent(index,userProvider.currentUser!.id);
                      },
                      child: TabEventWidget(
                        isSelected: eventListProvider.Selectedindex == index,

                        eventName: eventListProvider.eventsNameList[index],
                        backgroundColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight,
                        textSelectedStyle: AppStyles.semi16white,
                        textUnSelectedStyle: AppStyles.semi16Primary,
                      ),
                    );
                  },
                  itemCount: eventListProvider.eventsNameList.length,
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
                            return AppLocalizations.of(
                              context,
                            )!.pleaseentereventtitle;
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
                            return AppLocalizations.of(
                              context,
                            )!.pleaseentereventdescription;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.eventDescription,
                        style: AppStyles.semi16grey,
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),

                      child: ChooseDateOrTime(
                        iconName: AppAssets.IconDate,
                        eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                        onChooseDateOrTimeClicked: chooseDate,
                        chooseDateOrTime: selectedDate == null
                            ? AppLocalizations.of(context)!.chooseDate
                            : DateFormat("dd/MMM/yyyy").format(selectedDate!),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),

                      child: ChooseDateOrTime(
                        iconName: AppAssets.IconTime,
                        eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                        onChooseDateOrTimeClicked: chooseTime,
                        chooseDateOrTime: selectedTime == null
                            ? AppLocalizations.of(context)!.chooseTime
                            : formatedTime,
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

  Navigator.pushNamed(context, PickLocationScreen.route,arguments: provider);

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
                            color: AppColors.primaryLight,
                            width: 2,
                          ),
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
                            Expanded(
                              child: Text(
                                provider.eventLocation == null
                                    ? AppLocalizations.of(context)!
                                    .chooseEventLocation
                                    : "location${provider.eventLocation!
                                    .latitude}:${provider.eventLocation!
                                    .longitude}",
                                style: AppStyles.semi16Primary,
                              ),
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
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.002,
                      ),
                      child: CustomElevatedButton(
                        text: AppLocalizations.of(context)!.addEvent,
                        backgroundColor: AppColors.primaryLight,
                        onbuttonClicked: addEvent,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Future <void> addEvent() async {
    var provider=Provider.of<LocationProvider>(context,listen: false);

    if (formkey.currentState?.validate() == true) {
      if (selectedDate == null || selectedTime == null) {}
      if (provider.eventLocation==null){
        Fluttertoast.showToast(msg: "Location is Required",


        );
        return;

      }

      Event event = Event(
        title: titleController.text,
        description: descriptionController.text,
        date: formatedDate,
        time: formatedTime,
        image: selectedImage,
        dateTime: selectedDate!,
        eventName: selectedEvent,
lat: provider.eventLocation?.latitude??0,
        long: provider.eventLocation?.longitude??0,
      );
var userProvider=Provider.of<UserProvider>(context,listen: false);

      FirebaseUtils.addEventToFireStore(event ,userProvider.currentUser!.id)
          .then((value){

        Fluttertoast.showToast(
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.blackColor,
          gravity: ToastGravity.BOTTOM,
          msg: "event added successfully",

        );
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
        Navigator.pushReplacementNamed(context, HomeScreen.route);


      })
          
          .timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          Fluttertoast.showToast(
            backgroundColor: AppColors.whiteColor,
            textColor: AppColors.blackColor,
            gravity: ToastGravity.BOTTOM,
            msg: "event added successfully",
          );

          eventListProvider.getAllEvents(userProvider.currentUser!.id);
          Navigator.pop(context);

          return;
        },
      );
    }
  }

  void chooseDate() async {
    var choosedate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (choosedate == null) return;
    selectedDate = choosedate;
    formatedDate = DateFormat("dd/MMM/yyyy").format(choosedate);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chooseTime == null) return;
    selectedTime = chooseTime;

    formatedTime = selectedTime!.format(context);
    setState(() {});
  }
}

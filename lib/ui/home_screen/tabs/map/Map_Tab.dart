import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:evently/ui/widget/map_card_item.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late LocationProvider locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    locationProvider = Provider.of(context);

    return Consumer(
      builder: (context, value, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            locationProvider.getLocation();
          },
          child: Icon(Icons.gps_fixed),
        ),

        body: Stack(
          alignment: Alignment.bottomCenter,

          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: locationProvider.cameraPosition,
                    mapType: MapType.satellite,
                    onMapCreated: (mapController) {
                      locationProvider.mapController = mapController;
                    },
                    markers: locationProvider.markers,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 115,
              child: eventListProvider.filterEventList.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.noeventsfound),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01,
                          vertical: height * 0.01,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: eventListProvider.filterEventList.length,
                        itemBuilder: (context, index) {

                          return MapCardItem(
                            eventModel:
                                eventListProvider.filterEventList[index],
                            onPress: (lat, long) {
                              locationProvider.changeCameraPossitionOnMap(
                                LatLng( lat, long),
                              );
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatefulWidget {
  static const String route = "PickLocationScreen";

  final LocationProvider provider;

  const PickLocationScreen({super.key, required this.provider});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late LocationProvider provider = widget.provider;

  @override
  void initState() {
    super.initState();
    provider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,

      child: Consumer<LocationProvider>(
        builder: (context, value, child) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (location){


                    provider.changeLocation(location);
                    Navigator.pop(context);

                  },
                  zoomControlsEnabled: true,
                  initialCameraPosition: provider.cameraPosition,
                  mapType: MapType.satellite,
                  onMapCreated: (mapController) {
                    provider.mapController = mapController;
                  },
                  markers: provider.markers,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.primaryLight),
                child: Text(
                  AppLocalizations.of(context)!.tapOnLocationToSelect,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.ofWhitColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

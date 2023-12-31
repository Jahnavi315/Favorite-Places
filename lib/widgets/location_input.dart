import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget{
  LocationInput({super.key});
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  void _getCurrentLocation() async{
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    
  }
  @override
  Widget build(BuildContext context) {
    return Column( 
      children: [ 
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration( 
          border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
          ),
          alignment: Alignment.center,
          child: Text(
            'No location Choosen!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.normal
            ),
            //textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ 
            TextButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.location_on), 
              label: const Text('Get current location')
            ),
            TextButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.map), 
              label: const Text('Select on Map')
            )
          ],
        )
      ],
    );
  }
}
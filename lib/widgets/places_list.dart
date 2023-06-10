import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget{

  const PlacesList({super.key,required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    Widget content = Center( 
      child: Text(
        'No places added yet!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 22,
          color: Theme.of(context).colorScheme.onBackground
        )
      ),
    );
    if(places.isNotEmpty){
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
          child: ListTile( 
            leading: CircleAvatar(  
              radius: 25 ,
              backgroundImage: FileImage(places[index].image),
            ),
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlaceDetailsScreen(place: places[index])
              )
              );
            },
          ),
        )
      );
    }
    return content;
  }
}
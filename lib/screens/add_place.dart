import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget{
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen>{
  final _titleController = TextEditingController();
  File? _selectdImage;
  void _savePlace(){
    final enteredTitle = _titleController.text;//it cant be null at all
    if(enteredTitle.isEmpty || _selectdImage == null){
      showDialog(context: context, builder: (cxt) {
        return AlertDialog( 
          backgroundColor: Theme.of(cxt).colorScheme.background,
          title: Text(
            'Empty field is not accepted!',
            style: TextStyle( 
            color: Theme.of(cxt).colorScheme.onBackground,
            fontSize: 20
            )
          ),
          actions: [ 
            ElevatedButton(
              onPressed: (){
                Navigator.pop(cxt);
              }, 
              child: const Text('Okay')
            )
          ],
        );
      },
      );
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle,_selectdImage!);
    Navigator.of(context).pop();
  }
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: const Text(
          'Add new Place',
          style: TextStyle( 
            fontSize: 25
          ),
        ),
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(12),
        child: Column( 
          children: [
            TextField( 
              maxLength: 25,
              decoration: InputDecoration(  
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25
                )
              ),
              controller: _titleController,
              style: TextStyle( 
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 23
              ),
            ),
            const SizedBox( height: 16),
            ImageInput(onPickImage: (image){
              _selectdImage = image;
            }),
            const SizedBox( height: 16),
            LocationInput(),
            const SizedBox( height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace, 
              icon: const Icon(Icons.add),
              label:const Text('Add Place')
            )
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget{
  const ImageInput({super.key,required this.onPickImage});

  final void Function(File) onPickImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _saveImage() async{
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);//returns a future XFile => that conatins our picture
    if(pickedImage == null){
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);//give path to the constructor
    });
    
    widget.onPickImage(_selectedImage!);
  }
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _saveImage, 
        label: const Text('Take picture'),
        icon: const Icon(Icons.camera),
    );
    if(_selectedImage != null){
      content = GestureDetector(
        onTap: _saveImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          )
        );
    }
    return Container( 
      alignment: Alignment.center,//aligns its child in center h,v also
      decoration: BoxDecoration( 
        border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
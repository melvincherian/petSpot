// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'imagepicker_event.dart';
part 'imagepicker_state.dart';

class ImagepickerBloc extends Bloc<ImagepickerEvent, ImagepickerState> {

 final ImagePicker _picker=ImagePicker();

  ImagepickerBloc() : super(ImagepickerInitial()) {
    on<PickImageEvent>((event, emit)async {
       try{
       final PickedFile=await _picker.pickImage(source: ImageSource.gallery);
       if(PickedFile!=null){
        emit(ImagePickerSuccess(File(PickedFile.path)));
       }
       else{
        emit(ImagePickerFailure("No image is selected"));
       }
       
     }catch(e){
      emit(ImagePickerFailure("Failed to pick image:${e.toString()}"));
     }
    
    });
  }
}

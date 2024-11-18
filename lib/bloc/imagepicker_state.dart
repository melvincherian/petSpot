part of 'imagepicker_bloc.dart';

@immutable
sealed class ImagepickerState {}

final class ImagepickerInitial extends ImagepickerState {}

final class ImagePickerSuccess extends ImagepickerState{
  final File imageFile;

  ImagePickerSuccess(this.imageFile);
}

final class ImagePickerFailure extends ImagepickerState{
  final String message;

  ImagePickerFailure(this.message);
}
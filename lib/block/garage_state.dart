part of 'garage_bloc.dart';

@immutable
abstract class GarageState {}

class GarageInitial extends GarageState {}

class LoadingDataState extends GarageState {}

class ErrorDataState extends GarageState {
  final String message;

  ErrorDataState(this.message);
}

class LoadedDataState extends GarageState {
  final List<Garage>? garages;

  LoadedDataState(this.garages);
}

class ChangeBPState extends GarageState {
  final double bottom;

  ChangeBPState(this.bottom);
}


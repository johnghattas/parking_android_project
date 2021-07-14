part of 'garage_bloc.dart';

@immutable
abstract class GarageEvent {}

class GetDataEvent extends GarageEvent{}

class ChangeBPEvent extends GarageEvent{
  final double bottom;

  ChangeBPEvent(this.bottom);
}
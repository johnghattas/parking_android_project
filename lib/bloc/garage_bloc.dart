import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:parking_project/models/garage.dart';
import 'package:parking_project/repositers/parking_repo.dart';

part 'garage_event.dart';

part 'garage_state.dart';

class GarageBloc extends Bloc<GarageEvent, GarageState> {
  GarageBloc(parkingRepo)
      : this._parkingRepo = parkingRepo,
        super(GarageInitial());

  final ParkingRepo _parkingRepo;
  double bottomPosition = 0;

  @override
  Stream<GarageState> mapEventToState(
    GarageEvent event,
  ) async* {
    if (event is GetDataEvent) {
      yield LoadingDataState();
      try {
        List<Garage> garages = await _parkingRepo.getData();

        yield LoadedDataState(garages);
      } catch (e) {
        print(e);
        yield ErrorDataState(e.toString());
      }
    }

    //to change position
    if(event is ChangeBPEvent){
      bottomPosition = event.bottom;
      yield ChangeBPState(event.bottom);

    }
  }
}

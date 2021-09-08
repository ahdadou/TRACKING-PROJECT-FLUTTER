import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/shared/models/UserResponse.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery/services/repositories/deliveriesRepository.dart'
    as deliveryRepository;
part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitialState());

  @override
  Stream<DeliveryState> mapEventToState(
    DeliveryEvent event,
  ) async* {
    try {
      if (event is fetchDeliveriesData) {
        yield DeliveryLoadingState();
        // var list = await deliveryRepository.getDeliveriesByCountry();
        var list = await deliveryRepository.getAllUsers();
        if (list != null) {
          list.map((e) => print('--------------------- > ' + e.email));
          yield FetchDeliveriesSuccessState(userResponseList: list);
        } else
          yield DeliveryFaillerState();
      }
       if (event is fetchDeliveryByCityOrEmail) {
        yield DeliveryLoadingState();
        var list = await deliveryRepository.getDeliveriesByCityOrEmail(event.param);
        if (list != null) {
          list.map((e) => print('--------------------- > ' + e.email));
          yield FetchDeliveriesSuccessState(userResponseList: list);
        } else
          yield DeliveryFaillerState();
      }
    } catch (e) {
      yield DeliveryFaillerState();
    }
  }
}

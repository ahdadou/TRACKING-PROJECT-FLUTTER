part of 'delivery_bloc.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

class fetchDeliveriesData extends DeliveryEvent {}

class fetchDeliveryByCityOrEmail extends DeliveryEvent {
  final String param;
  fetchDeliveryByCityOrEmail({this.param});
  @override
  List<Object> get props => [];
}

class fetchDeliveryByEmail extends DeliveryEvent {}

class fetchDeliveriesbyCity extends DeliveryEvent {}

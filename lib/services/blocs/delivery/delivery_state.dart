part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();
  
  @override
  List<Object> get props => [];
}

class DeliveryInitialState extends DeliveryState {}

class DeliveryLoadingState extends DeliveryState {}

class FetchDeliveriesSuccessState extends DeliveryState {
  final List<UserResponse> userResponseList;
  FetchDeliveriesSuccessState({this.userResponseList});
}

class DeliveryFaillerState extends DeliveryState {}

part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}


class NotificationsLoadingState extends NotificationState {}

class FetchNotificationsSuccessState extends NotificationState {
  final List<Notifications> notifications;
  FetchNotificationsSuccessState({this.notifications});
}

class NotificationsFaillerState extends NotificationState {}
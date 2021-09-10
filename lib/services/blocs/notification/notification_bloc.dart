import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/shared/models/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery/services/repositories/notificationRepository.dart'
    as notificationRepository;
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is FetchNotificationEvent) {
      yield NotificationsLoadingState();
      List<Notifications> notifications =
          await notificationRepository.getNotifications();
      if (notifications != null)
        yield FetchNotificationsSuccessState(notifications: notifications);
      else
        yield NotificationsFaillerState();
    }
  }
}

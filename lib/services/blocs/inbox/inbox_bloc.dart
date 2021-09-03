import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/shared/models/inbox.dart';
import 'package:delivery/shared/models/messages.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery/services/repositories/chatRepository.dart'
    as chatRepository;
part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc() : super(InboxInitial());

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    try {
      if (event is FetchInbox) {
        yield FetchDataLoading();
        List<Inbox> inbox = await chatRepository.getInbox();
        yield FetchInboxSuccess(inbox: inbox);
      }

      if (event is FetchChat) {
        yield FetchDataLoading();
        List<Messages> messages =
            await chatRepository.getMessagesByInboxId(event.inboxId);
        chatRepository.messages$.add(messages);
        if (messages != null) yield FetchChatSuccess(messages: messages);
      }

      if (event is ReceivedMessagesEvent) {
        print(event.messages);
        // yield FetchedMessagesState(event.messages);
      }

      if (event is SendTextMessageEvent) {
        var message=await chatRepository.sendMessages(msg: event.messages,receiver_email: event.receiver_email);
        var messageslist=chatRepository.messages$.value;
        print(messageslist.length);
        messageslist.add(message);
        print(messageslist.length);
        chatRepository.messages$.sink.add(messageslist);

      }
    } catch (e) {
      yield FetchDataFailler();
    }
  }
}

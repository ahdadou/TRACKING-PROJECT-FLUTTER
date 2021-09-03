part of 'inbox_bloc.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object> get props => [];
}


class FetchInbox extends InboxEvent {
  @override
  List<Object> get props => [];
}

class FetchChat extends InboxEvent {
  final int inboxId;

  FetchChat({this.inboxId});
  @override
  List<Object> get props => [];
}



class ReceivedMessagesEvent extends InboxEvent {
  final List<Messages> messages;
  ReceivedMessagesEvent({this.messages}) ;
  @override
  String toString() => 'ReceivedMessagesEvent';
}

//triggered to send new text message
class SendTextMessageEvent extends InboxEvent {
  final String messages;
  final String receiver_email;
  SendTextMessageEvent( {this.receiver_email,this.messages}) ;

  @override
  String toString() => 'SendTextMessageEvent';
}
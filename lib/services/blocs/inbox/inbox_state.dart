part of 'inbox_bloc.dart';

abstract class InboxState extends Equatable {
  const InboxState();
  
  @override
  List<Object> get props => [];
}


class InboxInitial extends InboxState {
   @override
  List<Object> get props => [];
}

class FetchDataLoading extends InboxState {
   @override
  List<Object> get props => [];
}


class FetchInboxSuccess extends InboxState {
  final List<Inbox> inbox;

  FetchInboxSuccess({this.inbox});
   @override
  List<Object> get props => [];
}

class FetchChatSuccess extends InboxState {
  final List<Messages> messages;

  FetchChatSuccess({this.messages});
   @override
  List<Object> get props => [];
}

class FetchDataFailler extends InboxState {
   @override
  List<Object> get props => [];
}


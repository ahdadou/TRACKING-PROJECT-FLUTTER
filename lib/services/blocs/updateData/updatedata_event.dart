
import 'package:delivery/shared/models/userRequestDto.dart';
import 'package:equatable/equatable.dart';

abstract class UpdatedataEvent extends Equatable {
  const UpdatedataEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends UpdatedataEvent {
  UserRequestDTO userRequestDTO;
  UpdateUserData({this.userRequestDTO});
}

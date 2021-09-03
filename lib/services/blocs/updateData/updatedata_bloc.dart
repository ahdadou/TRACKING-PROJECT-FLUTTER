import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/services/blocs/updateData/updatedata_event.dart';
import 'package:delivery/services/blocs/updateData/updatedata_state.dart';
import 'package:delivery/services/repositories/LoginRepository.dart'
    as authRepository;

class UpdatedataBloc extends Bloc<UpdatedataEvent, UpdatedataState> {
  UpdatedataBloc() : super(UpdatedataInitial());

  @override
  Stream<UpdatedataState> mapEventToState(
    UpdatedataEvent event,
  ) async* {
    try {
      if (event is UpdateUserData) {
        yield UpdatedataLoading();
        print('------------------------ UpdatedataLoading');
        bool result = await authRepository.updateDataUser(event.userRequestDTO);
        if (result) {
          yield UpdatedataSuccess();
        } else {
          yield UpdatedataFailler();
        }
      }
    } catch (e) {
      print(e.toString());
      yield UpdatedataFailler();
    }
  }
}

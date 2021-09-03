
import 'package:equatable/equatable.dart';

abstract class UpdatedataState extends Equatable {
  const UpdatedataState();
  
  @override
  List<Object> get props => [];
}

class UpdatedataInitial extends UpdatedataState {}
class UpdatedataLoading extends UpdatedataState {}
class UpdatedataSuccess extends UpdatedataState {}
class UpdatedataFailler extends UpdatedataState {}

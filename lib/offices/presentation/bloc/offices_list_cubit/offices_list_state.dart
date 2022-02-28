import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OfficeState extends Equatable {
  const OfficeState();

  @override
  List<Object> get props => [];
}

class OfficeEmptyState extends OfficeState {
  @override
  List<Object> get props => [];
}

class OfficeLoadingState extends OfficeState {
  final List<OfficeEntity> oldOfficesList;
  final bool isFirstFetch;

  const OfficeLoadingState(this.oldOfficesList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldOfficesList];
}


class OfficeLoadedState extends OfficeState {
  final List<OfficeEntity> officesList;
  final bool thatAll;

  const OfficeLoadedState(this.officesList, this.thatAll);

  @override
  List<Object> get props => [officesList];
}

class OfficeErrorState extends OfficeState {
  final String message;

  const OfficeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
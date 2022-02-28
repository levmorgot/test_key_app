import 'package:equatable/equatable.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];
}

class NavbarEmptyState extends NavbarState {
  @override
  List<Object> get props => [];
}

class NavbarLoadingState extends NavbarState {
  @override
  List<Object> get props => [];
}

class NavbarChangedState extends NavbarState {
  final int currentTab;

  const NavbarChangedState(this.currentTab);

  @override
  List<Object> get props => [currentTab];
}



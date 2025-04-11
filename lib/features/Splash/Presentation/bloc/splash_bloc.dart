
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageChanged extends SplashEvent {
  final int index;
  PageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

abstract class SplashState extends Equatable {
  final int pageIndex;
  const SplashState(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class SplashIntial extends SplashState {
  SplashIntial() : super(0);
}

class SplashpageUpdate extends SplashState {
  SplashpageUpdate(int index) : super(index);
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashIntial()) {
    on<PageChanged>((event, emit) {
      emit(SplashpageUpdate(event.index));
    });
  }
}
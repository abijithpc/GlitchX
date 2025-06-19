import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/gametrailer_model.dart';

abstract class IGDBState {}

class IGDBInitial extends IGDBState {}

class IGDBLoading extends IGDBState {}

class IGDBLoaded extends IGDBState {
  final List<GameTrailerModel> trailers;
  IGDBLoaded(this.trailers);
}

class IGDBError extends IGDBState {
  final String message;
  IGDBError(this.message);
}

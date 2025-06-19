import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/UseCase/getupcomingtrailer_usecase.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_event.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_state.dart';

class IgdbBloc extends Bloc<IgdbEvent, IGDBState> {
  final GetupcomingtrailerUsecase _getupcomingtrailerUsecase;

  IgdbBloc(this._getupcomingtrailerUsecase) : super(IGDBInitial()) {
    on<LoadUpcomingTrailers>((event, emit) async {
      emit(IGDBLoading());
      try {
        final trailers = await _getupcomingtrailerUsecase();
        emit(IGDBLoaded(trailers));
      } catch (e) {
        emit(IGDBError(e.toString()));
      }
    });
  }
}

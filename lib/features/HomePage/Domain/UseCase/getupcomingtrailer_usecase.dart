import 'package:glitchxscndprjt/features/HomePage/Domain/Models/gametrailer_model.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Repository/igdb_repository.dart';

class GetupcomingtrailerUsecase {
  final IgdbRepository repository;

  GetupcomingtrailerUsecase(this.repository);

  Future<List<GameTrailerModel>> call() => repository.fetchUpcomingTrailers();
}

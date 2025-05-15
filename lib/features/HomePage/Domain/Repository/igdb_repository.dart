import 'package:glitchxscndprjt/features/HomePage/Domain/Models/gametrailer_model.dart';

abstract class IgdbRepository {
  Future<List<GameTrailerModel>> fetchUpcomingTrailers();
}

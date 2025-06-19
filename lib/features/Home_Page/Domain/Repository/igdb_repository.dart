import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/gametrailer_model.dart';

abstract class IgdbRepository {
  Future<List<GameTrailerModel>> fetchUpcomingTrailers();
}

import 'package:glitchxscndprjt/features/Home_Page/Data/DataSource/igdn_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/gametrailer_model.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Repository/igdb_repository.dart';

class IgdbRepositoryimpl implements IgdbRepository {
  final IgdbRemoteDatasource _remoteDatasource;

  IgdbRepositoryimpl(this._remoteDatasource);

  @override
  Future<List<GameTrailerModel>> fetchUpcomingTrailers() async {
    final trailers = await _remoteDatasource.getUpcomingGameTrailer();
    return trailers
        .map((e) => GameTrailerModel(name: e.name, videoId: e.videoId))
        .toList();
  }
}

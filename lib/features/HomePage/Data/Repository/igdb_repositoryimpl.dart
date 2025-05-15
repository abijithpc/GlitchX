import 'package:glitchxscndprjt/features/HomePage/Data/DataSource/igdn_remote_datasource.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Models/gametrailer_model.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Repository/igdb_repository.dart';

class IgdbRepositoryimpl implements IgdbRepository {
  final IgdbRemoteDatasource _remoteDatasource;

  IgdbRepositoryimpl(this._remoteDatasource);

  Future<List<GameTrailerModel>> fetchUpcomingTrailers() async {
    final trailers = await _remoteDatasource.getUpcomingGameTrailer();
    return trailers
        .map((e) => GameTrailerModel(name: e.name, videoId: e.videoId))
        .toList();
  }
}

import 'package:movie_app_redux/src/actions/index.dart';
import 'package:movie_app_redux/src/data/api_movie.dart';
import 'package:movie_app_redux/src/model/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

class AppEpics {
  AppEpics(this._apiMovie);

  final ApiMovie _apiMovie;

  Epic<AppState> get epic {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState,GetMovieStart>(_getMovieStart)
    ]);
  }

  Stream<dynamic> _getMovieStart(Stream<GetMovieStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMovieStart action) => _apiMovie.getMovies(action.page))
        .map((List<Movie> movies) => GetMovie.successful(movies))
    .onErrorReturnWith((Object error, StackTrace stackTrace) => GetMovie.error(error,stackTrace));
  }
}

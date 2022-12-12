import 'package:movie_app_redux/src/actions/index.dart';
import 'package:movie_app_redux/src/model/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovieStart>(_getMovieStart),
  TypedReducer<AppState, GetMovieSuccessful>(_getMovieSuccessful),
  TypedReducer<AppState, GetMovieError>(_getMovieError),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie)
]);

AppState _getMovieStart(AppState state, GetMovieStart action) {
  return state.copyWith(isLoading: true);
}

AppState _getMovieSuccessful(AppState state, GetMovieSuccessful action) {
  return state.copyWith(
    isLoading: false,
    movies: <Movie>[
      ...state.movies,
      ...action.movies,
    ],
  );
}

AppState _getMovieError(AppState state, GetMovieError action) {
  return state.copyWith(isLoading: false);
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.copyWith(selectedMovie: action.movie);
}

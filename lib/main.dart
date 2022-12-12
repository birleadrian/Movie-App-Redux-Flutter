import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:movie_app_redux/src/actions/index.dart';
import 'package:movie_app_redux/src/data/api_movie.dart';
import 'package:movie_app_redux/src/epics/app_epics.dart';
import 'package:movie_app_redux/src/model/index.dart';
import 'package:movie_app_redux/src/presentation/details_page.dart';
import 'package:movie_app_redux/src/presentation/home_page.dart';
import 'package:movie_app_redux/src/reducers/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<void> main() async {
  final Client client = Client();
  final ApiMovie api = ApiMovie(client);
  final AppEpics epics = AppEpics(api);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
    ],
  )..dispatch(const GetMovieStart(1));

  runApp(MovieApp(store: store));
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: const MoviePage(title: 'Movies'),
        routes: <String, WidgetBuilder>{
          '/details': (BuildContext context) => const DetailsPage(),
        },
      ),
    );
  }
}

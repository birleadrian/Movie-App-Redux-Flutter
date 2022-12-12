import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app_redux/src/actions/index.dart';
import 'package:movie_app_redux/src/model/index.dart';
import 'package:redux/redux.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, AppState state) {
        final List<Movie> movies = store.state.movies;
        final bool isLoading = store.state.isLoading;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Center(
              child: Text(
                'Movies',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: movies.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (movies.length == index) {
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
              final Movie movie = movies[index];
              return GestureDetector(
                onTap: () {
                  store.dispatch(SetSelectedMovie(movie));
                  Navigator.pushNamed(context, '/details');
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    movie.mediumImage,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

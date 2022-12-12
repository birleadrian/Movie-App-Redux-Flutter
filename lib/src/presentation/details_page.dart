import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app_redux/src/model/index.dart';
import 'package:redux/redux.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Movie>(
      converter: (Store<AppState> store) => store.state.selectedMovie!,
      builder: (BuildContext context, Movie movie) {
        final Store<AppState> store = StoreProvider.of<AppState>(context);
        final Movie movie = store.state.selectedMovie!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${movie.title} (${movie.year})',
              style: const TextStyle(color: Colors.white),
            ),
            elevation: 0,
          ),
          backgroundColor: Colors.amberAccent,
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  movie.largeImage,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    ' Rating: ${movie.rating.toString()}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Text(
                    ' Runtime: ${movie.runtime.toString()} minutes',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    movie.summary,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Available in:',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),
              for (final Torrent torrent in movie.torrents)
                ListTile(
                  title: Column(
                    children: <Widget>[
                      Text(
                        '${torrent.quality} ${torrent.type}',
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {
                          debugPrint('Download with quality ${torrent.quality} started!');
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          'Download',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

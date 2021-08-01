import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/genres.dart';
import 'package:movies/widgets/now_playing.dart';
import 'package:movies/widgets/people.dart';
import 'package:movies/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: const Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: const Text('Movie App'),
        actions: [
          IconButton(
            icon: const Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          Genres(),
          PeopleList(),
          TopMovies(),
        ],
      ),
    );
  }
}

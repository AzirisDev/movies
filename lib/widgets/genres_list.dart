import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movies_by_genre_bloc.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/genre_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;

  const GenresList({Key key, this.genres}) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;

  _GenresListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        movieListByGenreBloc.drainStream();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Style.Colors.mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.Colors.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Text(
                          e.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            preferredSize: const Size.fromHeight(60.0),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(genreId: genre.id);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

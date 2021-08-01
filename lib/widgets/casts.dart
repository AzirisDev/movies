import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/bloc/get_casts_bloc.dart';
import 'package:movies/model/cast.dart';
import 'package:movies/model/cast_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';

class Casts extends StatefulWidget {
  final int id;

  const Casts({Key key, this.id}) : super(key: key);

  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;

  _CastsState(this.id);

  @override
  void initState() {
    super.initState();
    castsBloc.getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
    castsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'CASTS',
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse>(
          stream: castsBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.isNotEmpty) {
                return CustomErrorWidget(
                  error: snapshot.data.error,
                );
              }
              return _buildCastsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return CustomErrorWidget(
                error: snapshot.data.error,
              );
            } else {
              return const CustomLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildCastsWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    return Container(
      height: 120,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            padding: const EdgeInsets.only(
              right: 10,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w300/' +
                          casts[index].img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  casts[index].name,
                  maxLines: 2,
                  style: const TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  casts[index].character,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Style.Colors.titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

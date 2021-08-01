import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/get_people_bloc.dart';
import 'package:movies/model/person.dart';
import 'package:movies/model/person_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key key}) : super(key: key);

  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  void initState() {
    super.initState();
    peopleBloc.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'TRENDING PEOPLE ON THIS WEEK',
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonResponse>(
          stream: peopleBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.isNotEmpty) {
                return CustomErrorWidget(error: snapshot.data.error,);
              }
              return _buildPeopleWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return CustomErrorWidget(error: snapshot.data.error,);
            } else {
              return const CustomLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildPeopleWidget(PersonResponse data) {
    List<Person> people = data.people;
    return Container(
      height: 120,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: people.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                people[index].profileImg == null
                    ? Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.Colors.secondColor),
                        child: const Icon(
                          FontAwesomeIcons.userAlt,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w200' +
                                    people[index].profileImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  people[index].name,
                  maxLines: 2,
                  style: const TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  'Trending for ${people[index].known}',
                  style: const TextStyle(
                    color:Style.Colors.titleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 7.0,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  const CustomErrorWidget({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error occured: $error'),
        ],
      ),
    );
  }
}

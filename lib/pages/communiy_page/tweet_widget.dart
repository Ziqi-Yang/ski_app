import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;
  const TweetWidget({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(16.0),
        child: ClipRRect(
          child: Image.network(
            tweet.avatar
          ),
        ),
      )
    ],
    );
  }
}

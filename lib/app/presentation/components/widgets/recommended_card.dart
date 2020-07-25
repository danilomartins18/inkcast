import 'package:flutter/material.dart';
import 'package:inkcast/app/domain/entities/podcast.dart';
import 'package:inkcast/app/shared/constants.dart';

class RecommendedCard extends StatelessWidget {
  final Podcast podcast;

  const RecommendedCard({Key key, this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 8.0,
            shadowColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: AssetImage(podcast.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            podcast.title,
            overflow: TextOverflow.ellipsis,
            style: inkTitleStyle,
          ),
          SizedBox(height: 5.0),
          Text(
            podcast.artist,
            overflow: TextOverflow.ellipsis,
            style: inkSubtitleStyle,
          )
        ],
      ),
    );
  }
}

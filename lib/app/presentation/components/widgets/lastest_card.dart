import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkcast/app/domain/entities/podcast.dart';
import 'package:inkcast/app/shared/constants.dart';

class LastestCard extends StatelessWidget {
  final Podcast podcast;

  const LastestCard({Key key, this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shadowColor: inkLightColor.withOpacity(.3),
      margin: EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 8.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        width: double.infinity,
        height: 120.0,
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage(podcast.image),
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: inkLightColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        podcast.genre,
                        style: inkFabStyle.copyWith(color: inkLightColor),
                      ),
                    ),
                    Spacer(),
                    Text(
                      podcast.title,
                      overflow: TextOverflow.ellipsis,
                      style: inkSubtitleStyle,
                    ),
                    Spacer(),
                    Text(
                      "By ${podcast.artist}",
                      overflow: TextOverflow.ellipsis,
                      style: inkSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: inkLightColor.withOpacity(.1),
                child: Icon(
                  FontAwesomeIcons.play,
                  color: inkLightColor,
                  size: 10.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

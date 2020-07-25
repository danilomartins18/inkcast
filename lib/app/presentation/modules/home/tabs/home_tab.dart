import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkcast/app/presentation/components/widgets/fab_icon.dart';
import 'package:inkcast/app/presentation/components/widgets/lastest_card.dart';
import 'package:inkcast/app/presentation/components/widgets/recommended_card.dart';
import 'package:inkcast/app/presentation/modules/podcast/player_page.dart';
import 'package:inkcast/app/shared/constants.dart';
import 'package:inkcast/mocks/podcast_mock.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Bom dia.\n",
                        style: inkTitleStyle.copyWith(color: Colors.grey),
                      ),
                      TextSpan(text: "Danilo", style: inkUsernameStyle),
                    ]),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 26.0,
                    backgroundImage: AssetImage("assets/images/danilomartins18.jpg"),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: TextField(
              cursorColor: inkLightColor,
              decoration: InputDecoration(
                hintText: "Procure por podcasts...",
                hintStyle: inkHintTextStyle,
                border: InputBorder.none,
                suffixIcon: Icon(
                  FontAwesomeIcons.search,
                  color: inkLightColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: <Widget>[
                FabIcon(
                  icon: FontAwesomeIcons.gem,
                  title: "Premium",
                  onTap: () {},
                ),
                FabIcon(
                  icon: FontAwesomeIcons.crown,
                  title: "Popular",
                  onTap: () {},
                ),
                FabIcon(
                  icon: FontAwesomeIcons.poll,
                  title: "Trending",
                  onTap: () {},
                ),
                FabIcon(
                  icon: FontAwesomeIcons.clock,
                  title: "Recente",
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: <Widget>[
                Text("Recomendados", style: inkCategoryTitleStyle),
                Spacer(),
                Text("Visualizar todos", style: inkCategorySubtitleStyle),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Container(
            width: double.infinity,
            height: 265.0,
            margin: EdgeInsets.only(left: 18.0),
            child: ListView.builder(
              itemCount: recommendedList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var podcast = recommendedList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerPage(podcast: podcast),
                        ),
                      );
                    },
                    child: RecommendedCard(podcast: podcast));
              },
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: <Widget>[
                Text("Últimas Playlists", style: inkCategoryTitleStyle),
                Spacer(),
                Text("Visualizar todos", style: inkCategorySubtitleStyle),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          ListView.builder(
            itemCount: latestList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var podcast = latestList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerPage(podcast: podcast),
                      ),
                    );
                  },
                  child: LastestCard(podcast: podcast));
            },
          ),
        ],
      ),
    ));
  }
}

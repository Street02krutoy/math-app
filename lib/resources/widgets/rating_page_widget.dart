import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/top_image_widgets.dart';
import 'package:flutter_app/resources/widgets/rating_element_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import "package:flutter_app/app/networking/api_service.dart";

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  createState() => _RatingPageState();
}

class _RatingPageState extends NyState<RatingPage> {
  _RatingPageState() {}

  final ApiService apiService = ApiService();
  static Future? ratingf;

  fetch() {
    ratingf = apiService.getUsersRating();
  }

  @override
  init() async {
    await fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("rating.page_name".tr()),
      ),
      body: FutureBuilder(
        future: ratingf,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map rating = snapshot.data;
            List userRating = rating["rating"];
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetch();
                });
                await ratingf;
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileTop(
                          place: 2,
                          name: userRating.length >= 2
                              ? userRating[1]["username"]
                              : null,
                          child: userRating.length >= 2
                              ? Image.network(getEnv("API_BASE_URL") +
                                  "/api/user/leader_photo/" +
                                  userRating[1]["id"])
                              : null,
                          rating: userRating.length >= 2
                              ? userRating[1]["rating"].toString()
                              : null,
                        ),
                        ProfileTop(
                          place: 1,
                          name: userRating[0]["username"],
                          child: Image.network(getEnv("API_BASE_URL") +
                              "/api/user/leader_photo/" +
                              userRating[0]["id"]),
                          rating: userRating[0]["rating"].toString(),
                        ),
                        ProfileTop(
                          place: 3,
                          name: userRating.length >= 3
                              ? userRating[2]["username"]
                              : null,
                          child: userRating.length >= 3
                              ? Image.network(getEnv("API_BASE_URL") +
                                  "/api/user/leader_photo/" +
                                  userRating[2]["id"])
                              : null,
                          rating: userRating.length >= 3
                              ? userRating[2]["rating"].toString()
                              : null,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 45,
                      ),
                      child: TopListItem(
                        place: rating["user_info"][1],
                        name: rating["user_info"][0]["username"],
                        rating: rating["user_info"][0]["rating"],
                        borderColor: Color.fromRGBO(255, 199, 0, 1),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userRating.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => TopListItem(
                          place: index + 1,
                          name: userRating[index]["username"],
                          rating: userRating[index]["rating"],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            dump("value15");
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: Text("general.error".tr()),
                    content: Text(snapshot.error.toString()),
                  );
                });
            return Center(
              child: Column(
                children: [Spacer(), CircularProgressIndicator(), Spacer()],
              ),
            );
          }
          return Center(
            child: Column(
              children: [Spacer(), CircularProgressIndicator(), Spacer()],
            ),
          );
        },
      ),
    );
  }
}

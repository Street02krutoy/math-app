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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Future ratingf = apiService.getUsersRating();

    return Scaffold(
      appBar: AppBar(
        title: Text("rating.page_name".tr()),
      ),
      body: FutureBuilder(
        future: ratingf,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map rating = snapshot.data;
            List real_rating = rating["rating"];
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
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
                          name: real_rating.length >= 2
                              ? real_rating[1]["username"]
                              : null,
                          child: real_rating.length >= 2
                              ? Image.network(getEnv("API_BASE_URL") +
                                  "/api/user/leader_photo/" +
                                  real_rating[1]["id"])
                              : null,
                          rating: real_rating.length >= 2
                              ? real_rating[1]["rating"].toString()
                              : null,
                        ),
                        ProfileTop(
                          place: 1,
                          name: real_rating[0]["username"],
                          child: Image.network(getEnv("API_BASE_URL") +
                              "/api/user/leader_photo/" +
                              real_rating[0]["id"]),
                          rating: real_rating[0]["rating"].toString(),
                        ),
                        ProfileTop(
                          place: 3,
                          name: real_rating.length >= 3
                              ? real_rating[2]["username"]
                              : null,
                          child: real_rating.length >= 3
                              ? Image.network(getEnv("API_BASE_URL") +
                                  "/api/user/leader_photo/" +
                                  real_rating[2]["id"])
                              : null,
                          rating: real_rating.length >= 3
                              ? real_rating[2]["rating"].toString()
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
                        itemCount: real_rating.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => TopListItem(
                          place: index + 1,
                          name: real_rating[index]["username"],
                          rating: real_rating[index]["rating"],
                        ),
                      ),
                    ),
                  ],
                ),
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

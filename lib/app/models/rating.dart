import 'package:nylo_framework/nylo_framework.dart';

/// Rating Model.

class Rating extends Model {
  Rating(this.name, this.rating, this.position);

  String? name;
  double? rating;
  int? position; //?

  Rating.fromJson(data) {
    position = data["position"];
    rating = data["rating"];
    name = data["name"];
  }

  @override
  toJson() => {"name": name, "position": position, "rating": rating};
}

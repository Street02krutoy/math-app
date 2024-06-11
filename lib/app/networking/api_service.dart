import 'package:flutter/material.dart';
import 'package:flutter_app/config/storage_keys.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:io';

/* ApiService
| -------------------------------------------------------------------------
| Define your API endpoints
| Learn more https://nylo.dev/docs/5.20.0/networking
|-------------------------------------------------------------------------- */

class ApiService extends NyApiService {
  ApiService({BuildContext? buildContext})
      : super(
          buildContext,
          decoders: modelDecoders,
          // baseOptions: (BaseOptions baseOptions) {
          //   return baseOptions
          //             ..connectTimeout = Duration(seconds: 5)
          //             ..sendTimeout = Duration(seconds: 5)
          //             ..receiveTimeout = Duration(seconds: 5);
          // },
        );

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  static TokenObject? _token = null;

  static Future<UserInfo> authenticate(
      {List<String> scopes = const ['openid']}) async {
    Auth.logout();
    // create the client
    var issuer = await Issuer.discover(Uri.parse(getEnv("SSO_URL")));
    var client = new Client(issuer, getEnv("CLIENT_ID"));

    // create a function to open a browser with an url
    urlLauncher(String url) async {
      try {
        await launchUrl(Uri.parse(url));
      } catch (e) {
        throw e;
      }
      // if (await canLaunchUrlString(url)) {
      // } else {
      //   throw 'Could not launch $url';
      // }
    }

    // create an authenticator
    var authenticator = new Authenticator(client,
        scopes: scopes, port: 4000, urlLancher: urlLauncher);

    // starts the authentication
    var c = await authenticator.authorize();

    // close the webview when finished
    closeInAppWebView();
    final d = await c.getTokenResponse();
    _token = TokenObject(
        expiresAt: d.expiresAt ?? DateTime.now(), token: d.accessToken ?? "");
    StorageKey.userToken.store(d.accessToken);

    await Auth.login(await c.getUserInfo());
    dump(Auth.user());

    // return the user info
    return await c.getUserInfo();
  }

  @override
  // ignore: overridden_fields
  final interceptors = {PrettyDioLogger: PrettyDioLogger()};

  // Future fetchTestData() async {
  //   return await network(
  //     request: (request) => request.get("/endpoint-path"),
  //   );
  // }

  /* Helpers
  |-------------------------------------------------------------------------- */

  /* Authentication Headers
  |--------------------------------------------------------------------------
  | Set your auth headers
  | Authenticate your API requests using a bearer token or any other method
  |-------------------------------------------------------------------------- */

  @override
  Future<RequestHeaders> setAuthHeaders(RequestHeaders headers) async {
    dump("value");
    String? myAuthToken = await StorageKey.userToken.read();
    if (myAuthToken != null) {
      headers.addBearerToken(myAuthToken);
    }
    dump(headers);

    return headers;
  }

  /* Should Refresh Token
  |--------------------------------------------------------------------------
  | Check if your Token should be refreshed
  | Set `false` if your API does not require a token refresh
  |-------------------------------------------------------------------------- */

  @override
  Future<bool> shouldRefreshToken() async {
    bool e = JwtDecoder.isExpired(await StorageKey.userToken.read());
    dump(e);
    return e;
  }

  /* Refresh Token
  |--------------------------------------------------------------------------
  | If `shouldRefreshToken` returns true then this method
  | will be called to refresh your token. Save your new token to
  | local storage and then use the value in `setAuthHeaders`.
  |-------------------------------------------------------------------------- */

  @override
  refreshToken(Dio dio) async {
    dynamic response =
        (await dio.get("${getEnv("SSO_URL")}/protocol/openid-connect/token"))
            .data;
    // Save the new token

    await StorageKey.userToken.store(response['token']);
  }

  /* Display a error
  |--------------------------------------------------------------------------
  | This method is only called if you provide the API service
  | with a [BuildContext]. Example below:
  | api<ApiService>(
  |        request: (request) => request.myApiCall(),
  |         context: context);
  |-------------------------------------------------------------------------- */

  displayError(DioException dioException, BuildContext context) {
    showToastNotification(context,
        title: "Error",
        description: dioException.message ?? "",
        style: ToastNotificationStyleType.DANGER);
  }

  // ВСЕ ЗАПРОСЫ К АПИ

  Future getUser() async {
    return await network(
      request: (request) {
        return request.get("/api/user");
      },
    );
  }

  Future getTopics() async {
    String lang = await NyStorage.read("com.srit.math.lang") ?? "ru";
    return await network<dynamic>(
        request: (request) {
          return request.get("/api/user/topics?lang=$lang");
        },
        connectionTimeout: Duration(minutes: 1));
  }

  Future getTopicDescription(int id) async {
    String lang = await NyStorage.read("com.srit.math.lang") ?? "ru";
    return await network(request: (request) {
      return request.get("/api/user/topic_description/${id}?lang=$lang");
    });
  }

  Future getTask(int id, int complexity) async {
    String lang = await NyStorage.read("com.srit.math.lang") ?? "ru";
    return await network(request: (request) {
      return request
          .get("/api/user/task/$id?lang=$lang&complexity=$complexity");
    });
  }

  Future getAchievements() async {
    String lang = await NyStorage.read("com.srit.math.lang") ?? "ru";
    return await network(request: (request) {
      return request.get("/api/user/achievements?lang=$lang");
    });
  }

  Future solvedTask(int id, int complexity) async {
    return await network(request: (request) {
      return request
          .patch("/api/user/solved_task/$id", data: {"complexity": complexity});
    });
  }

  Future getUsersRating() async {
    return await network(
      request: (request) {
        return request.get("/api/user/rating");
      },
    );
  }

  Future getUserProgress() async {
    String lang = await NyStorage.read("com.srit.math.lang") ?? "ru";
    return await network(
      request: (request) {
        return request.get("/api/user/progress?lang=$lang");
      },
    );
  }

  Future putUserPhoto(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return await network(
      request: (request) {
        return request.put("/api/user/photo", data: formData);
      },
    );
  }

  Future logout() async {
    return await Dio(BaseOptions(baseUrl: getEnv("SSO_URL")))
        .get("/protocol/openid-connect/logout");
  }
}

class TokenObject {
  final DateTime expiresAt;
  final String token;

  TokenObject({required this.expiresAt, required this.token});
}

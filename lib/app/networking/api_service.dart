import 'package:flutter/material.dart';
import 'package:flutter_app/config/storage_keys.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

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
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
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
  final interceptors = {
    if (getEnv('APP_DEBUG') == true) PrettyDioLogger: PrettyDioLogger()
  };

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
    return false;
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
        (await dio.get("https://example.com/refresh-token")).data;
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

  Future<dynamic> getUser() async {
    return await network(request: (request) {
      return request.get("/api/user");
    });
  }
}

class TokenObject {
  final DateTime expiresAt;
  final String token;

  TokenObject({required this.expiresAt, required this.token});
}

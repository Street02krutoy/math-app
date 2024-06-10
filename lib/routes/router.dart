import '/resources/pages/test_page.dart';
import '/resources/pages/theme_info_page.dart';
import '/resources/pages/mixed_themes_page.dart';
import 'package:flutter_app/resources/pages/login_page.dart';
import 'package:flutter_app/routes/guards/auth_route_guard.dart';

import '/resources/pages/reference_page.dart';
import '/resources/pages/progress_page.dart';
import '/resources/pages/achievements_page.dart';
import '/resources/pages/solve_page.dart';
import '/resources/pages/home_page.dart';
import 'package:flutter_app/resources/pages/settings_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.20.0/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      router
          .route(HomePage.path, (context) => HomePage(),
              initialRoute: true, authPage: true)
          .addRouteGuard(AuthRouteGuard());
      // Add your routes here

      // router.route(NewPage.path, (context) => NewPage(), transition: PageTransitionType.fade);

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      //   router.route(AccountPage.path, (context) => AccountPage());
      // });
      router.route(SolvePage.path, (context) => SolvePage());
      router.route(AchievementsPage.path, (context) => AchievementsPage());
      router.route(ProgressPage.path, (context) => ProgressPage());
      router.route(ReferencePage.path, (context) => ReferencePage());
      router.route(SettingsPage.path, (context) => SettingsPage());
      router.route(LoginPage.path, (context) => LoginPage());
      router.route(MixedThemesPage.path, (context) => MixedThemesPage());
  router.route(ThemeInfoPage.path, (context) => ThemeInfoPage());
  router.route(TestPage.path, (context) => TestPage());
});

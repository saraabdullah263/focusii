import 'package:focusi/features/auth/veiw/forget_passwrd.dart';
import 'package:focusi/features/auth/veiw/login.dart';
import 'package:focusi/features/auth/veiw/reset_password.dart';
import 'package:focusi/features/auth/veiw/signup.dart';
import 'package:focusi/features/children_result/veiw/children_result.dart';
import 'package:focusi/features/children_test/children_test_pages/child_test.dart';
import 'package:focusi/features/children_test/children_test_pages/game_test/veiw/game_screen.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/veiw/web_veiw_vedio.dart';
import 'package:focusi/features/children_test/children_test_welcom/childern_test_welcome.dart';
import 'package:focusi/features/home/main_veiw.dart';
import 'package:focusi/features/parent_test/veiw/parent_test.dart';
import 'package:focusi/features/parent_test/veiw/welcome_screen/parent_test_welcom.dart';
import 'package:focusi/screens/splash_screen/splach_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const ksignUp = '/signUp';
  static const klogin = '/login';
  static const kforgetPassword = '/forgetPassword';
  static const kparentTestWelcom = '/parentTestWelcom';
  static const kparentTest = '/parentTest';
  static const kchildTestWelcom = '/childTestWelcom';
  static const kchildTest = '/childTest';
  static const kgameScreen = '/gameScreen';
  static const kchildrenResult = '/childrenResult';
  static const kwebVeiwVideo='/webVeiwVideo';
  static const kresetPassword='/resetPassword';
  static const kmainVeiw='/mainVeiw';

  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplachScreen()),
      GoRoute(path: ksignUp, builder: (context, state) => const Signup()),
      GoRoute(path: klogin, builder: (context, state) => const Login()),
      GoRoute(
        path: kforgetPassword,
        builder: (context, state) => const ForgetPasswrd(),
      ),
      GoRoute(
        path: kparentTestWelcom,
        builder: (context, state) => const ParentTestWelcom(),
      ),
      GoRoute(
        path: kparentTest,
        builder: (context, state) => const ParentTest(),
      ),
      GoRoute(
        path: kchildTestWelcom,
        builder: (context, state) => const ChildernTestWelcome(),
      ),
      GoRoute(path: kchildTest, builder: (context, state) => const ChildTest()),
      GoRoute(
        path: kgameScreen,
        builder: (context, state) => const GameScreen(),
      ),
      GoRoute(
        path: kchildrenResult,
        builder: (context, state) => const ChildrenResult(),
      ),
       GoRoute(
        path: kwebVeiwVideo,
        builder: (context, state) =>  const WebVeiwVedio(),
      ),
      GoRoute(
        path: kresetPassword,
        builder: (context, state) =>  const ResetPassword(),
      ),
      GoRoute(
        path: kmainVeiw,
        builder: (context, state) =>  const MainVeiw(),
      ),
    ],
  );
}

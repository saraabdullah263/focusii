import 'package:focusi/features/auth/veiw/forget_passwrd.dart';
import 'package:focusi/features/auth/veiw/login.dart';
import 'package:focusi/features/auth/veiw/reset_password.dart';
import 'package:focusi/features/auth/veiw/signup.dart';
import 'package:focusi/features/children_result/veiw/children_result.dart';
import 'package:focusi/features/children_test/children_test_pages/child_test.dart';
import 'package:focusi/features/children_test/children_test_pages/game_test/veiw/game_screen.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/veiw/video_with_questions_screen.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/veiw/web_view.dart';
import 'package:focusi/features/children_test/children_test_welcom/childern_test_welcome.dart';
import 'package:focusi/features/home/veiw/advices_veiw.dart';
import 'package:focusi/features/home/veiw/feedback_veiw.dart';
import 'package:focusi/features/home/veiw/home_veiw.dart';
import 'package:focusi/features/home/veiw/main_veiw.dart';
import 'package:focusi/features/home/veiw/profile_veiw.dart';
import 'package:focusi/features/home/veiw/reports_veiw.dart';
import 'package:focusi/features/home/veiw/stories_veiw.dart';
import 'package:focusi/features/home/veiw/vedio_veiw.dart';
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
  static const kwebVeiwVideo = '/webVeiwVideo';
  static const kresetPassword = '/resetPassword';
  static const kmainVeiw = '/mainVeiw';
  static const kfeedbackVeiw = '/feedbackVeiw';
  static const kadvicesVeiw = '/advicesVeiw';
  static const kstoriesVeiw = '/storiesVeiw';
  static const khomeView = '/homeView';
  static const kprofileView = '/profileView';
  static const kreportsVeiw = '/reportsVeiw';
  static const kwebView = '/webView';
  static const kvideoScreenOn = '/videoScreenOn';
  static const kvideoScreenOff = '/videoScreenOff';
  static const kvideoWithQuestionsScreen='/videoWithQuestionsScreen';
  static const kvideoVeiw='/vedioVeiw';


  
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
        path: kresetPassword,
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(path: kmainVeiw, builder: (context, state) => const MainVeiw()),
      GoRoute(
        path: kfeedbackVeiw,
        builder: (context, state) => const FeedbackVeiw(),
      ),
      GoRoute(
        path: kadvicesVeiw,
        builder: (context, state) => const AdvicesVeiw(),
      ),
      GoRoute(
        path: kstoriesVeiw,
        builder: (context, state) => const StoriesVeiw(),
      ),
      GoRoute(path: khomeView, builder: (context, state) => const HomeVeiw()),
      GoRoute(
        path: kprofileView,
        builder: (context, state) => const ProfileVeiw(),
      ),
      GoRoute(
        path: kreportsVeiw,
        builder: (context, state) => const ReportsVeiw(),
      ),
       GoRoute(
        path: kwebView,
        builder: (context, state) => const WebViewScreen(),
      ),
     GoRoute(
  path: kvideoWithQuestionsScreen,
  builder: (context, state) {
    final camera = state.extra as bool? ?? true;
    return VideoWithQuestionsScreen(camera: camera);
  },
),
GoRoute(
        path: kvideoVeiw,
        builder: (context, state) => const VideoWithAudioQuestions(),
      ),

    ],
  );
}

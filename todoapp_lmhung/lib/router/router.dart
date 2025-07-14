import 'package:go_router/go_router.dart';
import 'package:todoapp_lmhung/screen/add_edit_todo_screen.dart';
import 'package:todoapp_lmhung/screen/admin_dashboard/admin_dashboard.dart';
import 'package:todoapp_lmhung/screen/home_page/homepage_choosetheme.dart';


class AppRouter {
  static String intro = "intro";
  static String introPath = "/intro";
  static String homeScreen = "/homescreen";

  static String chooseThemePath = '/chooseTheme';
  static String chooseThemeName = 'chooseTheme';

  static String dashboardPath = '/dashboard';
  static String dashboardName = 'dashboard';

  static String addTaskPath = '/dashboard/addtask';
  static String addTaskName = 'addtask';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        name: chooseThemeName,
        path: '/',
        builder: ((context, state) => const HomepageChoosetheme()),
      ),
      GoRoute(
        name: dashboardName,
        path: '/$dashboardName',
        builder: ((context, state) => const AdminDashboard()),
        routes: <RouteBase>[
          GoRoute(
            name: addTaskName,
            path: "/$addTaskName",
            builder: ((context, state) => const AddEditTodoScreen()),
          ),
        ],
      ),
    ],
  );
}

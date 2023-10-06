import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/app_navigation_bar.dart';
import 'package:moodflix/features/collection/ui/collection_page.dart';
import 'package:moodflix/features/discover/ui/discover_page.dart';
import 'package:moodflix/features/home/ui/home_page.dart';
import 'package:moodflix/features/login/login.dart';
import 'package:moodflix/features/login/ui/signin_page.dart';
import 'package:moodflix/features/login/ui/signup_page.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:moodflix/features/movie_details/movie_details.dart';
import 'package:moodflix/features/movie_search/movie_search.dart';
import 'package:moodflix/features/profile/ui/profile_page.dart';
import 'package:moodflix/features/settings/ui/settings_page.dart';
import 'package:moodflix/features/test/ui/test_animation.dart';
import 'package:moodflix/features/test/ui/test_page.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigator');

// GoRouter configuration
final router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
          // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
          return AppNavigationBar(navigationShell: navigationShell);
        },
        branches: [
          // The route branch for the Discover Tab
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          // The route branch for Map Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverPage(),
            ),
          ]),

          // The route branch for Social Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/collection',
              builder: (context, state) => const CollectionPage(),
            ),
          ]),

          // The route branch for Profile Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ])
        ],
      ),
      GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const Login(),
          routes: <RouteBase>[
            GoRoute(
              name: "signin",
              path: "signin",
              builder: (context, state) => const SignInPage(),
            ),
            GoRoute(
              name: "signup",
              path: "signup",
              builder: (context, state) => const SignUpPage(),
            ),
          ]),
      GoRoute(
        name: 'search_page',
        path: '/search_page',
        builder: (context, state) => const MovieSearch(),
      ),
      GoRoute(
          path: '/movie/:id',
          builder: (context, state) {
            Movie movie = state.extra as Movie;
            return MovieDetails(movie: movie);
          }),
      GoRoute(
        name: 'settings',
        path: '/settings',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'test',
        path: '/test',
        builder: (context, state) => const TestPage(),
      ),
      GoRoute(
        name: 'test_animation',
        path: '/test_animation',
        builder: (context, state) => const FirstPage(),
      ),
    ],

    // Debug
    debugLogDiagnostics: true,

    // Redirect user to home if he is authenticated
    redirect: (BuildContext context, GoRouterState state) {
      var config = AppConfig.of(context)!;
      final isAuthenticated = config.firebaseAuth.currentUser != null;
      if (!isAuthenticated) {
        return null;
        // return '/profile';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
    });

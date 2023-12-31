import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/core/app_navigation_bar.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/auth/ui/login_page.dart';
import 'package:moodflix/features/auth/ui/signin_page.dart';
import 'package:moodflix/features/auth/ui/signup_page.dart';
import 'package:moodflix/features/collection/ui/collection_page.dart';
import 'package:moodflix/features/collection/ui/rated_movies.dart';
import 'package:moodflix/features/collection/ui/wished_movies.dart';
import 'package:moodflix/features/discover/ui/discover_page.dart';
import 'package:moodflix/features/home/ui/home_page.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:moodflix/features/movie_details/movie_details.dart';
import 'package:moodflix/features/movie_search/movie_search.dart';
import 'package:moodflix/features/onboarding/ui/onboarding_page.dart';
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
              routes: <RouteBase>[
                GoRoute(
                  name: "rated_movies",
                  path: "rated_movies",
                  builder: (context, state) => const RatedMovies(),
                ),
                GoRoute(
                  name: "wished_movies",
                  path: "wished_movies",
                  builder: (context, state) => const WishedMovies(),
                ),
              ]),
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
        builder: (context, state) => const LoginPage(),
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: "signin",
            path: "signin",
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: "signup",
            path: "signup",
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: "onboarding",
            path: "onboarding",
            builder: (context, state) => const OnboardingPage(),
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
          // Modifications to handle screen restoring :
          // when user navigates away and then restore the page, the routing library is trying to reconstruct the state,
          // and in doing so, it likely uses a serialized form of the extra data
          // (which would be a Map<String, dynamic>), rather than the original Movie object.
          if (state.extra is Map<String, dynamic>) {
            Movie movie = Movie.fromJson(state.extra as Map<String, dynamic>);
            return MovieDetails(movie: movie);
          } else if (state.extra is Movie) {
            Movie movie = state.extra as Movie;
            return MovieDetails(movie: movie);
          } else {
            // Handle error or return an empty container
            return Container();
          }
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
    final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();
    final isAuthenticated = firebaseAuth.currentUser != null;
    final bool onConnexionPage = (state.matchedLocation == '/login/signup') ||
        (state.matchedLocation == '/login/signin');
    if (!isAuthenticated && !onConnexionPage) {
      return '/login';
    } else {
      return null; // return "null" to display the intended route without redirecting
    }
  },
);

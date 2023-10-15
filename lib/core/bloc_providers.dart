import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart'
    as collection_bloc;
import 'package:moodflix/features/auth/bloc/auth_bloc.dart' as auth_bloc;
import 'package:moodflix/features/discover/bloc/discover_bloc.dart'
    as discover_bloc;
import 'package:moodflix/features/home/bloc/home_bloc.dart' as home_bloc;
import 'package:moodflix/features/profile/bloc/profile_bloc.dart'
    as profile_bloc;

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authBloc = auth_bloc.AuthBloc();
    final homePageBloc = home_bloc.HomeBloc();
    // ..add(home_bloc.LoadDataEvent());
    final profileBloc = profile_bloc.ProfileBloc();
    // ..add(profile_bloc.LoadDataEvent());
    final collectionBloc = collection_bloc.CollectionBloc();
    // ..add(collection_bloc.LoadDataEvent());
    final discoverBloc = discover_bloc.DiscoverBloc();
    // ..add(discover_bloc.LoadDataEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authBloc),
        BlocProvider(create: (context) => homePageBloc),
        BlocProvider(create: (context) => profileBloc),
        BlocProvider(create: (context) => collectionBloc),
        BlocProvider(create: (context) => discoverBloc),
      ],
      child: BlocListener<auth_bloc.AuthBloc, auth_bloc.AuthState>(
        listener: (context, state) {
          // When the user is connected, load the data
          if (state is auth_bloc.AuthSuccessedState) {
            homePageBloc.add(home_bloc.LoadDataEvent());
            profileBloc.add(profile_bloc.LoadDataEvent());
            collectionBloc.add(collection_bloc.LoadDataEvent());
            discoverBloc.add(discover_bloc.LoadDataEvent());
          }
        },
        child: child,
      ),
    );
  }
}

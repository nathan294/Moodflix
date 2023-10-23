import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  // Classic initial stuff
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();
  RatingCubit() : super(RatingInitialState());

  FutureOr<void> rateMovie(int? rating) async {}

  FutureOr<void> unrateMovie() async {}
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';

part 'rating_cubit_state.dart';

class RatingCubitCubit extends Cubit<RatingCubitState> {
  // Classic initial stuff
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();
  RatingCubitCubit() : super(RatingCubitInitial());
}

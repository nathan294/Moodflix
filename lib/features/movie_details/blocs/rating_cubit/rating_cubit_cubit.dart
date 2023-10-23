import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rating_cubit_state.dart';

class RatingCubitCubit extends Cubit<RatingCubitState> {
  RatingCubitCubit() : super(RatingCubitInitial());
}

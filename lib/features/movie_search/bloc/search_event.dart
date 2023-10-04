part of 'search_bloc.dart';

@immutable
sealed class MovieSearchEvent {}

class TextChangeEvent extends MovieSearchEvent {
  final String text;

  TextChangeEvent({required this.text});

  List<Object> get props => [text];
}

class TextWipeEvent extends MovieSearchEvent {}

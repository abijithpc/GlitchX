import 'package:equatable/equatable.dart';

abstract class GeminiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends GeminiState {}

class ChatLoading extends GeminiState {}

class ChatLoaded extends GeminiState {
  final String response;

  ChatLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class ChatError extends GeminiState {
  final String message;

  ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

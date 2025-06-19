import 'package:equatable/equatable.dart';

abstract class GeminiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendPromptEvent extends GeminiEvent {
  final String prompt;

  SendPromptEvent(this.prompt);

  @override
  List<Object> get props => [prompt];
}

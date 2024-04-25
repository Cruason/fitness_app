import 'package:equatable/equatable.dart';

abstract class UpdateState extends Equatable{
  final String? message;

  const UpdateState({ this.message});

  @override
  List<Object> get props => [message??""];
}

class UpdateLoadingState extends UpdateState{
  const UpdateLoadingState();
}


class UpdateSuccessState extends UpdateState{
  const UpdateSuccessState(String message): super(message: message);
}

class UpdateErrorState extends UpdateState{
  const UpdateErrorState(String error): super(message: error);
}

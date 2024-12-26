abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class SignUpUser extends AuthenticationEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SignUpUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [firstName, lastName, email, password];
}

class LoginUser extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class EditProfile extends AuthenticationEvent {
  final String firstName;
  final String email;

  const EditProfile({
    required this.firstName,
    required this.email,
  });

  @override
  List<Object> get props => [firstName, email];
}

class SignOut extends AuthenticationEvent {}

class FetchUserToko extends AuthenticationEvent {
  final String userId;

  const FetchUserToko({required this.userId});

  @override
  List<Object> get props => [userId];
}

class FetchUserTransactions extends AuthenticationEvent {
  final String userId;

  const FetchUserTransactions({required this.userId});

  @override
  List<Object> get props => [userId];
}


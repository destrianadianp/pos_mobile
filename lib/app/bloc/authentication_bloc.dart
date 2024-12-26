import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user.dart';
import '../../services/authentication.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    // Handle user sign up
    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signUpUser(
          event.firstName, 
          event.lastName, 
          event.email, 
          event.password);
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('Failed to create user'));
        }
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      } finally {
        emit(AuthenticationLoadingState(isLoading: false));
      }
    });

    // Handle user login
    on<LoginUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.loginUser(
          event.email,
          event.password,
        );
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('Login failed'));
        }
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      } finally {
        emit(AuthenticationLoadingState(isLoading: false));
      }
    });

    // Handle profile update
    on<EditProfile>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        final User? firebaseUser = _firebaseAuth.currentUser;
        if (firebaseUser != null) {
          final bool success = await authService.editProfile(
            firebaseUser.uid,
            event.firstName,
            event.email,
          );
          if (success) {
            final UserModel updatedUser = UserModel(
              id: firebaseUser.uid,
              email: event.email,
              firstName: event.firstName,
            );
            emit(AuthenticationSuccessState(updatedUser));
          } else {
            emit(const AuthenticationFailureState('Failed to update profile'));
          }
        }
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      } finally {
        emit(AuthenticationLoadingState(isLoading: false));
      }
    });

    // Handle user logout
    on<SignOut>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        await authService.signOutUser();
        emit(AuthenticationInitialState());
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      } finally {
        emit(AuthenticationLoadingState(isLoading: false));
      }
    });

    on<FetchUserToko>((event, emit) async {
  emit(AuthenticationLoadingState(isLoading: true));
  try {
    final products = await authService.fetchUserToko(event.userId);
    emit(UserProductsLoadedState(products));
  } catch (e) {
    emit(AuthenticationFailureState(e.toString()));
  } finally {
    emit(AuthenticationLoadingState(isLoading: false));
  }
});

// on<FetchUserTransactions>((event, emit) async {
//   emit(AuthenticationLoadingState(isLoading: true));
//   try {
//     final transactions = await authService.fetchUserTransactions(event.userId);
//     emit(UserTransactionsLoadedState(transactions));
//   } catch (e) {
//     emit(AuthenticationFailureState(e.toString()));
//   } finally {
//     emit(AuthenticationLoadingState(isLoading: false));
//   }
// });

  }
}



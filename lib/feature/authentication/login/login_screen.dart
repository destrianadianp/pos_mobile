import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_mobile/app/bloc/authentication_bloc.dart';
import 'package:pos_mobile/app/bloc/authentication_event.dart';
import 'package:pos_mobile/app/bloc/authentication_state.dart';
import 'package:pos_mobile/feature/authentication/register/register_screen.dart';
import 'package:pos_mobile/feature/menu/menu_screen.dart';
import 'package:pos_mobile/feature/navigation/navigation_screen.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_button.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_button_outlined.dart';
import 'package:pos_mobile/feature/ui/typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _isSeen = ValueNotifier(false);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
   _passwordController.dispose();
   super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
               Text(
                "Sign in to your account",
                style: mlMedium.copyWith(color: textNeutralPrimary),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/mascot.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Masukan Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: _isSeen,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: !value,
                    decoration: InputDecoration(
                      hintText: 'Masukan Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isSeen.value = !_isSeen.value;
                        },
                        icon: SvgPicture.asset(
                          value
                              ? 'assets/images/ic_eye_slash.svg'
                              : 'assets/images/ic_eye_closed.svg',
                          color: iconNeutralPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: space1000),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                builder: (context,state){
                return  CustomButton(
                child:  Text(
                  "Login",
                  style: mMedium.copyWith(color: secondaryColor)
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoginUser(
                    email: _emailController.text.trim(), 
                    password: _passwordController.text.trim()));
                });
                }, 
                listener: (context, state){
                  if (state is AuthenticationSuccessState) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  NavigationScreen()),
                          (route)=>false);
                  }
                  else if (state is AuthenticationFailureState) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Text("Login failed. Please try again"));
                    });
              }
                }),
              
              
              const SizedBox(height: space600),
               Text(
                "or continue with",
                style: sMedium.copyWith(color: textDisabled)
              ),
              const SizedBox(height: 20),
              CustomButtonOutline(
                border: Border.all(color: black500),
                backgroundColor: secondaryColor,
                onPressed: () {
                  // Google Sign-In action
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png',
                        width: 25, height: 25),
                    const SizedBox(width: space300),
                    Text(
                      "Sign in with Google",
                      style: mMedium.copyWith(color: textNeutralPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Don't have an account?",
                    style: sMedium.copyWith(color: textDisabled)
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: mMedium.copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

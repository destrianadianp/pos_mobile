import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_mobile/app/bloc/authentication_event.dart';
import 'package:pos_mobile/app/bloc/authentication_state.dart';
import 'package:pos_mobile/feature/authentication/login/login_screen.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_button.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_text_form_field.dart';
import 'package:pos_mobile/feature/ui/typography.dart';

import '../../../app/bloc/authentication_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _isSeen = ValueNotifier(false);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAgreementChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Create an account",
          style: mlSemiBold,
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFAB43),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(screenPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        titleSection: 'First Name',
                        controller: _firstNameController,
                        backgroundColor: secondaryColor,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "First name tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        titleSection: 'Last Name',
                        controller: _lastNameController,
                        backgroundColor: secondaryColor,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Last name tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        titleSection: 'Email',
                        controller: _emailController,
                        backgroundColor: secondaryColor,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Email tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isSeen,
                        builder: (context, value, child) {
                          return CustomTextFormField(
                            maxLines: 1,
                            obsecureText: !value,
                            titleSection: 'Password',
                            backgroundColor: secondaryColor,
                            controller: _passwordController,
                            validator: (e) {
                              if (e.length < 8) {
                                return "Kata sandi minimal terdiri dari 8 karakter";
                              }
                              return null;
                            },
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
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isSeen,
                        builder: (context, value, child) {
                          return CustomTextFormField(
                            maxLines: 1,
                            obsecureText: !value,
                            titleSection: 'Confirm Password',
                            backgroundColor: secondaryColor,
                            controller: _confirmPasswordController,
                            validator: (e) {
                              if (e.length < 8) {
                                return "Kata sandi minimal terdiri dari 8 karakter";
                              }
                              // return null;
                              if (_passwordController.text!=_confirmPasswordController.text) {
                                return "Password tidak cocok";
                              }
                              return null;
                            },
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
                          );
                        },
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Checkbox(
                              value: _isAgreementChecked,
                              onChanged: (e) {
                                setState(() {
                                  _isAgreementChecked = e!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: space200,
                          ),
                          const Text(
                              "I have read the agreement and I accept it")
                        ],
                      ),
                      const SizedBox(height: space1000),
                      BlocConsumer<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            return CustomButton(
                              child:  Text("Sign Up",
                                  style: mMedium.copyWith(color: secondaryColor)
                                  ),
                              onPressed: _isAgreementChecked
                                  ? () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(SignUpUser(
                                              firstName: _firstNameController
                                                  .text
                                                  .trim(),
                                              lastName: _lastNameController
                                                  .text
                                                  .trim(),
                                              email: _emailController.text
                                                  .trim(),
                                              password: _passwordController
                                                  .text
                                                  .trim()));
                                    }
                                    }
                                  : null,
                            );
                          },
                          listener: (context, state) {
                            if (state is AuthenticationSuccessState) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            } else if (state
                                is AuthenticationFailureState) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content:
                                          Text("Error during Sign Up"),
                                    );
                                  });
                            }
                          }),
                      const SizedBox(
                        height: space400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: textDisabled),
                          ),
                          const SizedBox(width: space200),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: Text("Login",
                                  style: xsMedium.copyWith(
                                      color: primaryColor)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

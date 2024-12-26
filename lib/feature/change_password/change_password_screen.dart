import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_button.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_text_form_field.dart';

import '../ui/color.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
   final _isSeen = ValueNotifier(false);
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/key.png'),
          ValueListenableBuilder(
            valueListenable: _isSeen, 
            builder: (context, value, child){
              return CustomTextFormField(
                maxLines: 1,
                obsecureText: !value,
                placeholder: 'New Password',
                controller: _newPasswordController,
                validator: (e) {
                  if (e.length<8) {
                    return "Kata sandi minimal terdiri dari 8 karakter";
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: (){
                  _isSeen.value = !_isSeen.value;
                }, 
                icon: SvgPicture.asset(value ? 'assets/images/ic_eye_slash.svg': 'assets/images/ic_eye_closed.svg',color: iconNeutralPrimary,), 
                ),
              );
            }),
            const SizedBox(height: space100,),
            ValueListenableBuilder(
            valueListenable: _isSeen, 
            builder: (context, value, child){
              return CustomTextFormField(
                maxLines: 1,
                obsecureText: !value,
                placeholder: 'Confirm New Password',
                controller: _confirmNewPasswordController,
                validator: (e) {
                  if (e.length<8) {
                    return "Kata sandi salah";
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: (){
                  _isSeen.value = !_isSeen.value;
                }, 
                icon: SvgPicture.asset(value ? 'assets/images/ic_eye_slash.svg': 'assets/images/ic_eye_closed.svg',color: iconNeutralPrimary,), 
                ),
              );
            }),
            const SizedBox(height: space300,),
            CustomButton(child: const Text("Save"),
            onPressed: () {
              
            },)
        ],
      ),),
    );
  }
}
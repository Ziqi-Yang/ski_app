import 'package:flutter/material.dart';
import 'package:ski_app/pages/login/login.dart';
import 'package:ski_app/pages/login/register.dart';
import 'package:ski_app/widget/common_widget.dart';

class AccountSheet extends StatelessWidget {
  const AccountSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _tile(context, Icons.switch_account, "切换账户", (){funcNotSupportDialog(context);}),
                _tile(context, Icons.login, "登陆账户", () {
                  onTapSlide(context: context, pageChild: const LoginScreen());
                }),
                _tile(context, Icons.person_add_alt, "注册新账户", (){
                  onTapSlide(context: context, pageChild: const RegisterScreen());
                }),
                _tile(context, Icons.logout, "退出账户", () { funcNotSupportDialog(context);}),
                _tile(context, Icons.person_remove, "注销账户", (){
                  funcNotSupportDialog(context);})
              ],
            ),
          ),
        );
  }

  _tile(BuildContext context, IconData iconData, String text, void Function()? func){
    return ListTile(
        leading: Icon(iconData),
        title: Text(
          text, style: Theme.of(context).textTheme.bodyText1,
        ),
        onTap: func,
      );
  }
}

import 'package:flutter/material.dart';
import 'package:ski_app/pages/login/login.dart';
import 'package:ski_app/pages/login/background.dart';


class RegisterScreen extends StatefulWidget{
  final bool fromLogin;
  const RegisterScreen({Key? key, this.fromLogin=false}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "注册",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36
                ),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child:
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: const InputDecoration(
                  labelText: "用户名",
                ),
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "用户名不能为空";
                },
              )
            ),


            SizedBox(height: size.height * 0.03),

            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child:
                TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: const InputDecoration(
                    labelText: "邮箱",
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "邮箱不能为空"; // FIXME
                  },
                )
            ),
            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _pwdController,
                decoration: const InputDecoration(
                  labelText: "密码",
                ),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v!.trim().length > 5 ? null : "密码不能少于6位"; // FIXME 过滤
                },
              ),
            ),

            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    print("success"); // FIXME 发送数据请求
                  }
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(color: Colors.white),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ]
                      )
                  ),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "注册",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  if (widget.fromLogin){
                    Navigator.of(context).pop();
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(fromRegister: true,)));
                  }
                },
                child: const Text(
                  "已经有账户了? 立即登陆",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
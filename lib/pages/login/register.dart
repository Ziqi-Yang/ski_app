import 'package:flutter/material.dart';
import 'package:ski_app/pages/login/login.dart';
import 'package:ski_app/pages/login/background.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "用户名"
                ),
              ),
            ),


            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "邮箱"
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "密码"
                ),
                obscureText: true,
              ),
            ),

            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
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
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
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
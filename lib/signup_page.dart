import 'package:animattio_mobile_app/login_page.dart';
import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

//Page for registration
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    //Colors
    Color fontColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color inputColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFF2A470C);

    //Strings
    String signUpTitle = "Sign up";
    String toLogInString = "Already have an account? Sign in";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: pageColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: width,
                    height: height * 0.3,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset('assets/login_page/star_login.png'),
                    ),
                  ),
                ),
                 Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment:Alignment.topCenter,
            child: 
            Text(
              signUpTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fontColor,
                fontSize: 60,
                fontFamily: 'Lilita One',
              ),
            ),),
          ),
                Positioned(
                  top: deviceSize.height * 0.3,
                  width: deviceSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,5),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inputColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter username:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.4,
                  width: deviceSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,5),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inputColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter email:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.5,
                  width: deviceSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,5),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inputColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter password:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.6,
                  width: deviceSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,5),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inputColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Repeat password:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.75,
                  width: deviceSize.width,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const UserPage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'Lilita One',
                            fontWeight: FontWeight.w900),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                      ),
                      child: Text(
                        signUpTitle,
                        style: TextStyle(color: fontColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginPage();
                  }));
                },
                child: Text(
                  toLogInString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontFamily: 'Lilita One',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

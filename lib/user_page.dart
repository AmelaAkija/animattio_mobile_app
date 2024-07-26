import 'package:animattio_mobile_app/avatar_page.dart';
import 'package:animattio_mobile_app/theme_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
 final String? userAvatar;
 const UserPage({super.key, this.userAvatar});

  @override
  Widget build(BuildContext context) {

    //Strings
    String userTitle = "My profile";
    String gameButton = "play game";
    String settingsButton = "settings";
    String avatarButton = "change avatar";
    String avatarMessage = "No avatar\n selected";
    

    //Colors
    Color pageColor = const Color(0xFFF7A559);
        Color messageColor = const Color(0xFFF7A559);

    Color buttonColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color titleColor = const Color(0xFF2A470C);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;


    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            height: height,
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/user_page/star_user_3.png',
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: height * 0.2,
            // height: height * 0.5,
            width: width*0.5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/user_page/star_user_2.png',
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: height * 0.24,
            width: width * 0.4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/user_page/star_user_1.png',
              ),
            ),
          ),
          //TODO: message when avatar not selected?

          // if (userAvatar == null)
          //   Positioned(
          //      top: height * 0.35,
          //      child: 
          //     Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //     child: Align(
          //       alignment: Alignment.center,
          //       child: Text(
          //         avatarMessage,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: messageColor,
          //           fontSize: 20,
          //           fontFamily: 'Lilita One',
          //         ),


          //       ),
          //     ),),
          //   ),
          if(userAvatar !=null)
          Positioned(
          left: 0,
            top: height * 0.35,
            width: width * 0.3,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(userAvatar!, //null check operator
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  userTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 60,
                    fontFamily: 'Lilita One',
                  ),
                ),
                SizedBox(height: height * 0.55), // in the middle of page
                SizedBox(
                  width: width*0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const AvatarPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      avatarButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                const SizedBox(height:5 ),
                SizedBox(
                  width: width*0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ThemePage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      gameButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width*0.5,
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
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      settingsButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

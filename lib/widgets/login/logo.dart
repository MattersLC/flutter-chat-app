import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            //const Image(image: AssetImage('assets/undraw_messaging_fun.svg')),
            SvgPicture.asset(
              'assets/undraw_messaging_fun.svg',
              height: 200,
            ),
            //const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: ChatColors.mint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

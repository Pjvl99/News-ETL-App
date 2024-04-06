import 'package:flutter/material.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hola, Usuario', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: deviceWidth/17, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          SizedBox(
              width: double.infinity,
              height: deviceHeight/3,
              child: const FadeInImage(placeholder: AssetImage('assets/loading.gif'), image: AssetImage("assets/patricio.jpg")
              )
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class NewsCard extends StatelessWidget {
  String title;
  String author;
  String date;
  String imageUrl;
  String description;
  NewsCard({Key? key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chermas app'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
              children: [
                Text(title, style: TextStyle(fontSize: deviceWidth/15), maxLines: 4, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Text('Por: $author  -   $date', style: TextStyle(fontSize: deviceWidth/35), maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 10,),
                Container(
                    width: deviceWidth,
                    height: deviceHeight/3.5,
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(imageUrl),
                      imageErrorBuilder: (context, object, stackTrace) => Image.asset("assets/noimage.png")
                    )),
                SizedBox(height: 10,),
                HtmlWidget(description != "" ? description : "<html></html>")
              ],
            ),
        ),
      ),
    );
  }
}

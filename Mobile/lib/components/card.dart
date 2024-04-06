import 'package:flutter/material.dart';

import '../views/newsCard.dart';

class CardComponent extends StatelessWidget {
  String imageUrl;
  String title;
  String category;
  String date;
  String author;
  String description;

  CardComponent({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.date,
    required this.author,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newUrl = "";
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  onTap: () => Navigator.push(context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => NewsCard(
                            author: author,
                            description: description,
                            title: title,
                            date: date,
                            imageUrl: newUrl != "" ? newUrl : imageUrl,
                          )
                      )
                  ),
                  leading: Container(
                      alignment: Alignment.center,
                      height: deviceHeight/10,
                      width: deviceWidth/5,
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: NetworkImage(imageUrl),
                        imageErrorBuilder: (context, object, stackTrace) => Image.asset("assets/noimage.png"),
                      )
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: deviceWidth/25),),
                      SizedBox(height: deviceHeight/25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: deviceWidth/1.7,
                              child: Text('$date | $category', style: TextStyle(fontSize: deviceWidth/33), maxLines: 1, overflow: TextOverflow.ellipsis,)
                          )
                        ],
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}

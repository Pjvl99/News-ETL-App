import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_project/client/apiFunctions.dart';
import 'package:news_project/components/card.dart';
import 'package:news_project/components/easyloading.dart' as component;

import '../client/responses/getAll.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with AutomaticKeepAliveClientMixin<MainView> {
  final ScrollController scrollController = ScrollController();
  List<GetAll> items = [];
  ApiFunctions apiFunctions = ApiFunctions();
  int page = 1;
  bool update = true;
  bool loading = false;
  @override

  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!loading) appendItems();
      }
    });
    appendItems();
  }

  void appendItems() async {
    setState(() {
      loading = true;
    });
    component.showLoading('loading...');
    apiFunctions.getAll(page.toString()).then((value) {
      if (value != []) {
        setState(() {
          items.addAll(value);
          page += 1;
          loading = false;
          scrollController.animateTo(scrollController.position.pixels - 150,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        });
      }
      EasyLoading.dismiss();
    });
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PrimaryScrollController(
      controller: scrollController,
      child: ListView.builder(
        primary: true,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) => CardComponent(
            imageUrl: items[index].imgUrl,
            title: items[index].title,
            category: items[index].category,
            date: items[index].date,
            author: items[index].author,
            description: items[index].description),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

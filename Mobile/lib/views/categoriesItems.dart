import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_project/components/card.dart';
import 'package:news_project/components/easyloading.dart' as component;

import '../client/apiFunctions.dart';
import '../client/responses/category.dart';
class CategoriesItemsView extends StatefulWidget {
  String category;
  CategoriesItemsView({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  State<CategoriesItemsView> createState() => _CategoriesItemsViewState();
}

class _CategoriesItemsViewState extends State<CategoriesItemsView> {
  final ScrollController scrollController = ScrollController();
  List<Category> items = [];
  ApiFunctions apiFunctions = ApiFunctions();
  int page = 1;
  String searchValue = "";
  bool update = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && items.isNotEmpty) {
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
    apiFunctions.getCategoryItems(page.toString(), widget.category).then((value) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.red,
      ),
      body: PrimaryScrollController(
        controller: scrollController,
        child: ListView.builder(
            primary: true,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => CardComponent(
          imageUrl: items[index].imgUrl,
          title: items[index].title,
          category: items[index].subcategory,
          date: items[index].date,
          author: items[index].author,
          description: items[index].description,
        )),
      )
    );
  }
}

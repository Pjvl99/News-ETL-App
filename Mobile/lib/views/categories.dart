import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_project/client/responses/category.dart';
import 'package:news_project/client/responses/getCategories.dart';
import 'package:news_project/views/categoriesItems.dart';
import 'package:news_project/components/easyloading.dart' as component;

import '../client/apiFunctions.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> with AutomaticKeepAliveClientMixin<CategoriesView> {
  bool update = true;
  List<GetCategories> items = [];
  ApiFunctions apiFunctions = ApiFunctions();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    component.showLoading('loading...');
    apiFunctions.getCategories().then((value) {
      setState(()  => items.addAll(value));
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    super.build(context);
    return SingleChildScrollView(
      child: SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: ListView(
          children: List.generate(
            items.length, (index) => ListTile(
            leading: const Icon(Icons.abc),
            onTap: () => Navigator.push(
              context, PageRouteBuilder(pageBuilder: (_, __, ___) => CategoriesItemsView(category: items[index].category))
            ),
            title: Text(items[index].category),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          )
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

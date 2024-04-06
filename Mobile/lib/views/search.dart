import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_project/components/card.dart';
import 'package:news_project/components/easyloading.dart' as component;
import '../client/apiFunctions.dart';
import '../client/responses/search.dart';
import 'newsCard.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin<SearchView> {
  final ScrollController scrollController = ScrollController();
  List<Search> items = [];
  ApiFunctions apiFunctions = ApiFunctions();
  int page = 1;
  String searchValue = "";
  bool update = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && searchValue.isNotEmpty) {
        if (!loading) appendItems(false, searchValue);
      }
    });
  }

  void appendItems(bool clear, String searchValue) async {
    if (clear) {
      if (scrollController.hasClients) {
        scrollController.animateTo(5,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn);
      }
      items.clear();
      page = 1;
    }
    setState(() {
      loading = true;
    });
    component.showLoading('loading...');
    if (items.length % 20 == 0) {
      apiFunctions.getSearchResults(page.toString(), searchValue).then((value) {
        if (value.isNotEmpty) {
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
    } else {
      EasyLoading.dismiss();
    }

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              searchValue = value;
              appendItems(true, searchValue);
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),

          ),
          SizedBox(
            height: deviceHeight/1.5,
            child: PrimaryScrollController(
                controller: scrollController,
                child: ListView.builder(
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CardComponent(
                      imageUrl: items[index].imgUrl,
                      title: items[index].title,
                      category: items[index].category,
                      date: items[index].category,
                      author: items[index].author,
                      description: items[index].description),
                )),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

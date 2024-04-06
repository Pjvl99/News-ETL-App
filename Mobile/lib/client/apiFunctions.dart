
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:news_project/client/responses/category.dart';
import 'package:news_project/client/responses/getAll.dart';
import 'package:news_project/client/responses/getCategories.dart';
import 'package:news_project/client/responses/search.dart';

import 'apiMethods.dart';

class ApiFunctions {
  Future<List<GetCategories>> getCategories() async {
    var url = Uri.parse(ApiMethods().getCategories());
    var headers = {
      'Content-Type': 'application/json'
    };
    var resp = await http.get(url, headers: headers);
    if (resp.statusCode == 200 && resp.body != '[]') {
      var response = getCategoriesFromJson(resp.bodyBytes);
      return response;
    }
    return [];
  }

  Future<List<GetAll>> getAll(String page) async {
    var url = Uri.parse(ApiMethods().getAll());
    var headers = {
      'Content-Type': 'application/json',
      'page': page
    };
    var resp = await http.get(url, headers: headers);
    if (resp.statusCode == 200 && resp.body != '[]') {
      var response = getAllFromJson(resp.bodyBytes);
      return response;
    }
    return [];
  }

  Future<List<Category>> getCategoryItems(String page, String category) async {
    var url = Uri.parse(ApiMethods().getCategoryItems());
    var headers = {
      'Content-Type': 'application/json',
      'page': page,
      'value': Uri.encodeComponent(category)
    };
    var resp = await http.get(url, headers: headers);
    if (resp.statusCode == 200 && resp.body != '[]') {
      var response = getCategoryFromJson(resp.bodyBytes);
      return response;
    }
    return [];
  }

  Future<List<Search>> getSearchResults(String page, String value) async {
    var url = Uri.parse(ApiMethods().search());
    var headers = {
      'Content-Type': 'application/json',
      'page': page,
      'value': Uri.encodeComponent(value)
    };
    var resp = await http.get(url, headers: headers);
    if (resp.statusCode == 200 && resp.body != '[]') {
      var response = getSeachResultsFromJson(resp.bodyBytes);
      return response;
    }
    return [];
  }

}
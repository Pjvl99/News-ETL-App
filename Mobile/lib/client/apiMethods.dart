
String testUrl = 'http://10.0.2.2:5000';
String prodUrl = 'https://flask-server-ttzp4gqkyq-uc.a.run.app';
bool isProduction = true;

class ApiMethods {
  getCategories() {
    return '${isProduction ? prodUrl : testUrl}/getcategories';
  }
  search() {
    return '${isProduction ? prodUrl : testUrl}/search';
  }
  getAll() {
    return '${isProduction ? prodUrl : testUrl}/all';
  }
  getCategoryItems() {
    return '${isProduction ? prodUrl : testUrl}/category';
  }
}
import 'package:http/http.dart' as http;
import 'package:news_api_app/models/article_model.dart';
import 'dart:convert';

class News {
  List<ArticleModel> news = [];
  String url =
      "https://newsapi.org/v2/everything?q=tesla&from=2025-08-27&sortBy=publishedAt&apiKey=3aa66a534dbe4bdea05f7a067f7a5fec";

  Future<void> getNews() async {
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articleModel);
        }

        // ArticleModel articleModel=new ArticleModel();
        // articleModel.title=element["title"];
        // articleModel.author=element["author"];
        // articleModel.description=element["description"];
        // articleModel.url=element["url"];
        // articleModel.urlToImage=element["urlToImage"];
        // articleModel.content=element["content"];
        // news.add(articleModel);
      });
    }
  }
}

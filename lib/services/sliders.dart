import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api_app/models/slider_model.dart';

// List<SliderModel> getSliders() {
//   List<SliderModel> slider = [];
//   SliderModel categoryModel = new SliderModel();

//   categoryModel.image = "images/building.jpg";
//   categoryModel.name = "Bow to the authority of silent force";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();

//   categoryModel.image = "images/business.jpg";
//   categoryModel.name = "Bow to the authority of silent force";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();

//   categoryModel.image = "images/entertainment.jpg";
//   categoryModel.name = "Bow to the authority of silent force";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();

//   categoryModel.image = "images/health.jpg";
//   categoryModel.name = "Bow to the authority of silent force";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();

//   return slider;
// }
class Sliders {
  List<SliderModel> slider = [];
  String url ="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3aa66a534dbe4bdea05f7a067f7a5fec";

  Future<void> getSlider() async {
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          SliderModel sliderModel = SliderModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          slider.add(sliderModel);
        }
      });
    }
  }
}

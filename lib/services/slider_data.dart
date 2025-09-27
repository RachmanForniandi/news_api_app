import 'package:news_api_app/models/slider_model.dart';

List<SliderModel> getSliders() {
  List<SliderModel> slider = [];
  SliderModel categoryModel = new SliderModel();

  categoryModel.image = "images/building.jpg";
  categoryModel.name = "Bow to the authority of silent force";
  slider.add(categoryModel);
  categoryModel = new SliderModel();

  categoryModel.image = "images/business.jpg";
  categoryModel.name = "Bow to the authority of silent force";
  slider.add(categoryModel);
  categoryModel = new SliderModel();

  categoryModel.image = "images/entertainment.jpg";
  categoryModel.name = "Bow to the authority of silent force";
  slider.add(categoryModel);
  categoryModel = new SliderModel();

  categoryModel.image = "images/health.jpg";
  categoryModel.name = "Bow to the authority of silent force";
  slider.add(categoryModel);
  categoryModel = new SliderModel();

  return slider;
}

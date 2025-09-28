import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api_app/models/article_model.dart';
import 'package:news_api_app/models/slider_model.dart';
import 'package:news_api_app/pages/article_view.dart';
import 'package:news_api_app/services/news.dart';
import 'package:news_api_app/services/sliders.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {

  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  //bool _loading = true;

  int activeIndex = 0;

  @override
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      //_loading = false;
    });
  }


  getSlider() async {
    Sliders sliderNewsClass = Sliders();
    await sliderNewsClass.getSlider();
    sliders = sliderNewsClass.slider;
    setState(() {
      //_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.news+" News",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: 
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: widget.news=="Breaking"? sliders.length:articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              Image: widget.news=="Breaking"? sliders[index].urlToImage!:articles[index].urlToImage!,
              title: widget.news=="Breaking"? sliders[index].title!:articles[index].title!,
              desc: widget.news=="Breaking"? sliders[index].description!:articles[index].description!,
              url: widget.news=="Breaking"? sliders[index].url!:articles[index].url!,
            );
          },
        ),
      ),
    );
  }

}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title,url;
  AllNewsSection({required this.Image, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              title, 
            maxLines: 2,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text(desc, maxLines: 3),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
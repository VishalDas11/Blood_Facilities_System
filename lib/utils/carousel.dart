import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int activeindex = 0;
  final imageUrl = [
    'https://img.freepik.com/premium-psd/donate-blood-banner-template_23-2148690140.jpg?w=740',
    'https://img.freepik.com/free-psd/donate-blood-campaign-banner-template_23-2148690135.jpg?w=740&t=st=1667714809~exp=1667715409~hmac=d65e022b351c1d7c138aa134f1363695314efeeed4854ef9a074ee02b39f63d2',
    'https://img.freepik.com/free-psd/donate-blood-campaign-horizontal-banner_23-2148690136.jpg?w=740&t=st=1667714724~exp=1667715324~hmac=7edcfd52452c99d2eefbdab9eaa309d8c42cb534b5858578c866a2506df43d11',
    'https://img.freepik.com/free-psd/donate-blood-campaign-banner_23-2148690137.jpg?w=740&t=st=1667715864~exp=1667716464~hmac=0d6a29061914e63b9b2daa5c000a805f9c125fbd03d5697492033769c28900a1',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: imageUrl.length,
            itemBuilder: (context, index, realIndex) {
              final imageUrls = imageUrl[index];
              return buildImage(imageUrls, index);
            },
            options: CarouselOptions(
                // height: MediaQuery.of(context).size.height *1/4,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => activeindex = index);
                }),
          ),
          SizedBox(
            height: 10,
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildImage(String imageUrls, int index) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrls,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget buildIndicator() =>
      AnimatedSmoothIndicator(activeIndex: activeindex, count: imageUrl.length,);
}

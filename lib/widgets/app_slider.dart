import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/data/model/slider.dart';
import 'package:watch_store/resources/dimensions.dart';

class AppSlider extends StatefulWidget {
  const AppSlider({super.key, required this.imgList});
  final List<HomeSlider> imgList;

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  final CarouselSliderController _controller = CarouselSliderController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 250,
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _controller,
            items:
                widget.imgList
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.all(Dimensions.medium),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.medium,
                          ),
                          child: Image.network(
                            element.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                widget.imgList
                    .asMap()
                    .entries
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.all(Dimensions.small),
                        child: GestureDetector(
                          onTap: () => _controller.animateToPage(element.key),
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                              color:
                                  _currentIndex == element.key
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

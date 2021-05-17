import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class Flurousel<T> extends StatefulWidget {

  final List<T> items;
  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final double carouselHeight;

  Flurousel({
    @required this.items,
    @required this.itemWidgetBuilder,
    this.carouselHeight = 300,
  });

  @override
  State<StatefulWidget> createState() => _FluroState<T>();
}

class _FluroState<T> extends State<Flurousel<T>> {
  /*final _scrollController = ScrollController();*/

  final _pageController = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1,
  );

  int _currentIndex = 0;

  final double indicatorContainerHeight = 50.0;
  final double selectedIndicatorWidth = 40.0;
  final double indicatorWidth = 20.0;
  final double indicatorHeight = 5.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        double carouselWidth = MediaQuery.of(context).size.width;
        if (_pageController.positions.isNotEmpty && _pageController.offset % carouselWidth == 0){
          //_currentIndex = (_scrollController.offset / carouselWidth).round();
          _currentIndex = _pageController.page.toInt();
          print("$_currentIndex");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.carouselHeight,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: widget.items.length,
            controller: _pageController,
            physics: PageScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: widget.itemWidgetBuilder(context, widget.items[index]),
              );
            },
            scrollDirection: Axis.horizontal,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: indicatorContainerHeight,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.items.map((item) {
                  return Container(
                    width: widget.items[_currentIndex] == item ? selectedIndicatorWidth : indicatorWidth,
                    height: indicatorHeight,
                    margin: EdgeInsets.symmetric(horizontal: 2,),
                    decoration: BoxDecoration(
                      color: widget.items[_currentIndex] == item ? Colors.white : Colors.black45,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
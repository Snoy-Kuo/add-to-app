import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';
import 'package:flutter_module/widgets/stock_ticker/view/stock_ticker_cell.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StockTickerView extends StatelessWidget {
  final Function(QuotItem? item)? onItemClick;
  final controller = PageController(viewportFraction: 1 / 1);

  StockTickerView({this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 116 / 375,
      child: Center(
        child: BlocBuilder<StockTickerBloc, StockTickerState>(
          builder: (context, state) {
            if (state is StockTickerError) {
              return Text(state.msg);
            } else if (state is StockTickerLoaded) {
              return Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 104 / 375,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: (state.list.length / 3).floor() + 1,
                    itemBuilder: (context, index) {
                      return _initCell(state.list, index);
                    },
                  ),
                ),
                SmoothPageIndicator(
                    controller: controller, // PageController
                    count: (state.list.length / 3).floor() + 1,
                    effect: SlideEffect(
                        spacing: 4,
                        radius: 4,
                        dotHeight: 4,
                        dotWidth: 4,
                        strokeWidth: 0,
                        activeDotColor: const Color(0xFFCCCCCC),
                        dotColor: const Color(0xFFF0F0F0)),
                    onDotClicked: (index) {
                      controller.jumpToPage(index);
                    }),
              ]);
            } else {
              //if (state is BannerLoading){
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      // ),
    );
  }

  Widget _initCell(List<QuotItem> list, int index) {
    var item1, item2, item3;
    try {
      item1 = list[index * 3];
    } catch (ignore) {}
    try {
      item2 = list[index * 3 + 1];
    } catch (ignore) {}
    try {
      item3 = list[index * 3 + 2];
    } catch (ignore) {}
    // return your view for page view
    return Row(
      children: [
        Expanded(
          child: StockTickerCell(
            item: item1,
            onItemClick: onItemClick,
          ),
        ),
        Expanded(
          child: StockTickerCell(
            item: item2,
            onItemClick: onItemClick,
          ),
        ),
        Expanded(
          child: StockTickerCell(
            item: item3,
            onItemClick: onItemClick,
          ),
        ),
      ],
    );
  }
}

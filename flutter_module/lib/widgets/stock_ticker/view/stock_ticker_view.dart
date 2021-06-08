import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_repo.dart';
import 'package:flutter_module/widgets/stock_ticker/view/stock_ticker_cell.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StockTickerView extends StatelessWidget {
  final QuotRepo repository;
  final Function(QuotItem? item)? onItemClick;
  late final StockTickerBloc _bloc;
  final controller = PageController(viewportFraction: 1 / 1);

  StockTickerView({required this.repository, this.onItemClick}) {
    _bloc = StockTickerBloc(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StockTickerBloc>(
      create: (context) => _bloc..add(RefreshStockTicker()),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 116 / 375,
        // color: Colors.grey,
        child: Center(
          child: BlocBuilder<StockTickerBloc, StockTickerState>(
            builder: (context, state) {
              log('StockTickerBloc state=$state');
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
                        var item1, item2, item3;
                        try {
                          item1 = state.list[index * 3];
                        } catch (ignore) {}
                        try {
                          item2 = state.list[index * 3 + 1];
                        } catch (ignore) {}
                        try {
                          item3 = state.list[index * 3 + 2];
                        } catch (ignore) {}
                        // return your view for pageview
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
      ),
    );
  }

  void refresh() {
    _bloc.add(RefreshStockTicker());
  }

  void update(QuotItem item) {
    _bloc.add(UpdateStockTicker(item: item));
  }
}

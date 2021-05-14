import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/widgets/banner/bloc/banner_bloc.dart';
import 'package:flutter_module/widgets/banner/model/model.dart';

class BannerView extends StatelessWidget {
  final BannerRepo repository;
  final Function(BannerItem? item)? onItemClick;
  late final BannerBloc _bloc;

  BannerView({required this.repository, this.onItemClick}) {
    _bloc = BannerBloc(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BannerBloc>(
      create: (context) => _bloc..add(RefreshBanner()),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 158 / 375,
        color: Colors.grey,
        child: Center(
          child: BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              if (state is BannerError) {
                return Text(state.msg);
              } else if (state is BannerLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    aspectRatio: 375 / 158,
                  ),
                  items: state.list
                      .map(
                        (item) => InkWell(
                          onTap: () {
                            if (onItemClick != null) onItemClick!(item);
                          },
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )
                      .toList(),
                );
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
    _bloc.add(RefreshBanner());
  }
}

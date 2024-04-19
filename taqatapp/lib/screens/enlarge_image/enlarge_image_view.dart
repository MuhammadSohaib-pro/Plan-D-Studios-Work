import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taqat/screens/enlarge_image/enlarge_image_viewmodel.dart';
import 'package:taqat/widgets/loader_view.dart';

class EnlargeImageView extends StatelessWidget {
  EnlargeImageView({Key? key}) : super(key: key);
  final EnlargeImageViewModel viewModel = Get.put(EnlargeImageViewModel());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: appBar(),
        body: Stack(
          children: [
            image(),
            const LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(''),
    );
  }

  Widget image() {
    return Container(
      color: Colors.white,
      child: CachedNetworkImage(
          imageUrl: viewModel.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          placeholder: (context, url) => Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xfffafafa),
                      ),
                    ),
                  ),
                ),
              ),
          errorWidget: (context, url, error) {
            return (viewModel.imageUrl != null && viewModel.imageUrl != "")
                ? Center(
                    child: Image.file(
                      File(viewModel.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  )
                : const Image(
                    image: AssetImage('assets/images/default_image.png'),
                  );
          }),
    );
  }
}

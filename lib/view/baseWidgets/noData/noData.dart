import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../../util/images.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          width: width,
          //height: height * 0.5,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Images.no_data),
              Flexible(
                  child: Text(
                "NO DATA",
                style: robotoBold.copyWith(color: ColorResources.WHITE),
              ))
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:zentry/src/core/utils/app_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 9,
              offset: Offset(0, 2),
              spreadRadius: 0),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: SvgPicture.asset(
                AppImages.imagesCustomSearch,
                colorFilter: ColorFilter.mode(
                  Color(0xff949d9e),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // suffixIcon: SizedBox(
          //   width: 20,
          //   height: 20,
          //   child: Center(
          //     child: SvgPicture.asset(
          //       AppImages.imagesFilterIcon,
          //     ),
          //   ),
          // ),
          hintText: 'Search Tasks,Tags,lists and filters',
          hintStyle: AppStyles.regular13.copyWith(
            color: const Color(0xff949d9e),
          ),
          filled: true,
          fillColor: Colors.white,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        width: 1,
        //color: Color(0xffe6e9e9),
        color: Colors.white,
      ),
    );
  }
}

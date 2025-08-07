import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:zentry/src/core/utils/app_styles.dart';
import 'package:zentry/src/core/widgets/search_text_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          SearchTextField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width *
                      0.2, // Adjusted radius based on screen width
                  // Placeholder image, replace with your own image asset
                  backgroundImage:
                      AssetImage(AppImages.searchLogo), // Placeholder image
                ),
                Text(
                  'What do u want to search',
                  style: AppStyles.bold16,
                ),
                const SizedBox(height: 10),
                Text(
                  'Tap the input box to search',
                  style: AppStyles.regular13.copyWith(
                    color: const Color(0xff949d9e),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

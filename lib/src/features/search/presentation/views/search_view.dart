import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_images.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search tasks, tags, lists and filters',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for the binoculars image.
                  // You would use an Image.asset or Image.network here
                  // if you had the image file.
                  Image.asset(
                    AppImages.searchLogo, // Replace with your image path
                    height: 150,
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'What do you want to search',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Tap the input box to search',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// Expanded(
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: MediaQuery.of(context).size.width *
//                       0.2, // Adjusted radius based on screen width
//                   // Placeholder image, replace with your own image asset
//                   backgroundImage:
//                       AssetImage(AppImages.searchLogo), // Placeholder image
//                 ),
//                 Text(
//                   'What do u want to search',
//                   style: AppStyles.bold16,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Tap the input box to search',
//                   style: AppStyles.regular13.copyWith(
//                     color: const Color(0xff949d9e),
//                   ),
//                 ),
//               ],
//             ),
//           ),

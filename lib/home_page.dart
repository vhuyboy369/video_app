// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_app/cores/widgets/image_button.dart';

import 'cores/screens/error_page.dart';
import 'cores/screens/loader.dart';
import 'features/auth/provider/user_provider.dart';
import 'features/content/bottom_navigation.dart';
import 'features/upload/upload_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                //Hiển thị thông tin dựa theo user hiện tại
                Consumer(
                  builder: (context, ref, child) {
                    //Nếu có data lỗi hoặc đang loading thì sẽ hiển thị giao diện tùy theo user
                    return ref.watch(currentUserProvider).when(
                          data: (currentUser) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => AccountPage(
                              //         user: currentUser,
                              //       ),
                              //     ),
                              //   );
                              // },
                              //Avatar
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic,
                                ),
                              ),
                            ),
                          ),
                          error: (error, stackTrace) => const ErrorPage(),
                          loading: () => const Loader(),
                        );
                  },
                ),
              ],
            ),
            // Expanded(
            //   child: pages[currentIndex],
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   onPressed: (index) {
      //     if (index != 2) {
      //       currentIndex = index;
      //       setState(() {});
      //     } else {
      //       showModalBottomSheet(
      //         context: context,
      //         builder: (context) => const CreateBottomSheet(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}

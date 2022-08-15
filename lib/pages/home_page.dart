import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobbiest_flutter/models/category_model.dart';
import 'package:jobbiest_flutter/models/job_model.dart';
import 'package:jobbiest_flutter/providers/category_provider.dart';
import 'package:jobbiest_flutter/providers/job_provider.dart';
import 'package:jobbiest_flutter/providers/user_provider.dart';
import 'package:jobbiest_flutter/theme.dart';
import 'package:jobbiest_flutter/widgets/custom_list.dart';
import 'package:jobbiest_flutter/widgets/job_card.dart';
import 'package:provider/provider.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var categoryProvider = Provider.of<CategoryProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);

    Widget header() {
      return Container(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Howdy',
                  style: titleTextStyle,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  userProvider.user.name ?? '',
                  style: subTitleTextStyle,
                ),
              ],
            ),
            Spacer(),
            Stack(alignment: Alignment.center, children: [
              Image.asset(
                'assets/Ellipse.png',
                height: 58,
              ),
              Image.asset(
                'assets/pic.png',
                height: 50,
              )
            ])
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hot Categories',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff272C2F))),
            SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<CategoryModel>>(
                  future: categoryProvider.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      int index = -1;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: snapshot.data!.map((category) {
                          index++;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: JobCard(category),
                          );
                        }).toList(),
                        // children: [
                        //   JobCard('Website Developer', 'assets/work1.png'),
                        //   SizedBox(
                        //     width: 16,
                        //   ),
                        //   JobCard('Mobile Developer', 'assets/work2.png'),
                        //   SizedBox(
                        //     width: 16,
                        //   ),
                        //   JobCard('App Designer', 'assets/work3.png'),
                        //   SizedBox(
                        //     width: 16,
                        //   ),
                        //   JobCard('Content Writer', 'assets/work4.png'),
                        //   SizedBox(
                        //     width: 16,
                        //   ),
                        //   JobCard('Video Grapher', 'assets/work5.png'),
                        //   SizedBox(
                        //     width: 16,
                        //   ),
                        // ],
                      );
                    }
                    return Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff4141A4)),
                    );
                  }),
            ),
            SizedBox(height: 30),
            Text('Just Posted',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff272C2F))),
            SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  children: [
                    FutureBuilder<List<JobModel>>(
                        future: jobProvider.getJobs(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Column(
                              children: snapshot.data!
                                  .map((job) => CustomList(job))
                                  .toList(),
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        })
                    // CustomList('Front-End Developer', 'Google',
                    //     'assets/ic_google.png'),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // CustomList(
                    //     'UI Designer', 'Instagram', 'assets/ic_instagram.png'),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // CustomList(
                    //     'Data Scientist', 'Facebook', 'assets/ic_facebook.png'),
                  ],
                ))
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(top: 30),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                unselectedItemColor: Color(0xffB3B5C4),
                selectedItemColor: Color(0xff272C2F),
                currentIndex: 0,
                elevation: 0,
                iconSize: 24,
                items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/navbar1.png')),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/navbar2.png')),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/navbar3.png')),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/navbar4.png')),
                      label: '')
                ]),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  SizedBox(
                    height: 30,
                  ),
                  body(),
                ],
              ),
            ),
          )),
    );
  }
}

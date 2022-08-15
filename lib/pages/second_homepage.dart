import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobbiest_flutter/models/category_model.dart';
import 'package:jobbiest_flutter/theme.dart';
import 'package:jobbiest_flutter/widgets/custom_list.dart';
import 'package:provider/provider.dart';

import '../models/job_model.dart';
import '../providers/job_provider.dart';

class SecondHomePage extends StatelessWidget {
  // final String jobTitleHome;
  // final String imageUrl;
  final CategoryModel category;

  SecondHomePage(this.category);
  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: Image.network(
                        category.imageUrl ?? '',
                        fit: BoxFit.cover,
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, top: 178),
                      child:
                          Text(category.name ?? '', style: jobTitleTextStyle),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 216),
                      child: Text(
                        '12,309 available',
                        style: availableJobTextStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Big Companies',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff272C2F))),
                        SizedBox(height: 16),
                        FutureBuilder<List<JobModel>>(
                            future: jobProvider
                                .getJobsByCategory(category.name ?? ''),
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
                      ],
                    )),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Startups',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff272C2F))),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
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
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

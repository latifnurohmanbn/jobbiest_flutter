import 'package:flutter/material.dart';
import 'package:jobbiest_flutter/models/job_model.dart';
import 'package:jobbiest_flutter/pages/detail_page.dart';
import 'package:jobbiest_flutter/theme.dart';

class CustomList extends StatelessWidget {
  // final String name;
  // final String companyName;
  // final String companyLogo;
  final JobModel job;

  CustomList(this.job);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailPage(job)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            job.companyLogo ?? '',
            height: 45,
          ),
          SizedBox(
            width: 27,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.name ?? '',
                  style: jobTextStyle,
                ),
                SizedBox(height: 2),
                Text(
                  job.companyName ?? '',
                  style: companyTextStyle,
                ),
                SizedBox(height: 18),
                Divider(
                  color: Color(0xffECEDF1),
                  thickness: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobbiest_flutter/models/job_model.dart';
import 'package:jobbiest_flutter/theme.dart';

class DetailPage extends StatefulWidget {
  final JobModel job;

  DetailPage(this.job);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isApplied = false;
  @override
  Widget build(BuildContext context) {
    Widget applyButton() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        height: 45,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                isApplied = !isApplied;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xff4141A4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(66),
              ),
            ),
            child: Text(
              'Apply Job',
              style: buttonTextStyle,
            )),
      );
    }

    Widget cancelButton() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        height: 45,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                isApplied = !isApplied;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xffFD4F56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(66),
              ),
            ),
            child: Text(
              'Cancel Apply',
              style: buttonTextStyle,
            )),
      );
    }

    Widget successAppliedMessages() {
      return Container(
        height: 60,
        width: 312,
        decoration: BoxDecoration(
          color: Color(0xffECEDF1),
          borderRadius: BorderRadius.circular(49),
        ),
        child: Center(
          child: Text(
            'You have applied this job and the\nrecruiter will contact you',
            style: GoogleFonts.poppins(
              color: Color(0xffA2A6B4),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget detailItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Image.asset(
              'assets/dot.png',
              height: 12,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: requrementsTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              isApplied ? successAppliedMessages() : SizedBox(height: 40),
              SizedBox(height: 30),
              Image.network(
                widget.job.companyLogo ??
                    '', // pakai widget karena statefull widget
                height: 60,
              ),
              SizedBox(height: 20),
              Text(
                widget.job.name ?? '',
                style: jobApplyTextStyle,
              ),
              SizedBox(height: 2),
              Text(
                '${widget.job.companyName} • ${widget.job.location}',
                style: companyTextStyle,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About the job',
                      style: titleRequrementsTextStyle,
                    ),
                    Column(
                      children: widget.job.about!
                          .map(
                            (text) => detailItem(text),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Qualifications',
                      style: titleRequrementsTextStyle,
                    ),
                    Column(
                      children: widget.job.qualifications!
                          .map(
                            (text) => detailItem(text),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Responsibilities',
                      style: titleRequrementsTextStyle,
                    ),
                    Column(
                      children: widget.job.responsibilities!
                          .map(
                            (text) => detailItem(text),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 51,
              ),
              isApplied ? cancelButton() : applyButton(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  child: Text(
                    'Message Recruiter',
                    style: titleTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

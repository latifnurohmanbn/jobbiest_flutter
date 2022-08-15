import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobbiest_flutter/pages/second_homepage.dart';

import '../models/category_model.dart';

class JobCard extends StatelessWidget {
  // final String name;
  // final String imageUrl;
  final CategoryModel category;

  JobCard(this.category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondHomePage(category),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 150,
          height: 200,
          child: Stack(
            children: [
              Image.network(
                category.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                  child: Text(category.name ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/Model/watch_later_model.dart';

class FavMovieTile extends StatelessWidget {
  final WL_Model favModel;

  const FavMovieTile(
      {super.key, required this.favModel});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    Results movieInfo = Results.fromJson(favModel.movieData);

    return GestureDetector(
      onLongPress: favModel.onLongPress,
      onTap: favModel.onTap,
      child: Container(
        width: maxWidth,
        height: maxHeight * 0.18,
        decoration: BoxDecoration(
          color: favModel.color,
          borderRadius: BorderRadius.circular(maxWidth * 0.03),
        ),
        child: Row(
          children: [
            Container(
              height: maxHeight,
              width: maxWidth * 0.4,
              color: favModel.color.withBlue(20),
              child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://image.tmdb.org/t/p/w500/""${movieInfo.posterPath}",),),
            ),
            SizedBox(
              width: maxWidth * 0.05,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "${movieInfo.title}",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    "${movieInfo.overview}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

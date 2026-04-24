import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/banner_model.dart';


class BannerSlide extends StatelessWidget {
  final BannerModel banner;

  const BannerSlide({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x142D5A27),
            offset: const Offset(0, 24),
            blurRadius: 48,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            /// Background Image
            SizedBox(
              width: double.infinity,
              height: 180.h,
              child: Image.asset(
                banner.imagePath,
                fit: BoxFit.cover,
              ),
            ),

            /// Overlay for readability
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            /// Text Content
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Title
                    Text(
                      banner.title,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        fontSize: 40.sp,
                        height: 48 / 40,
                        letterSpacing: -0.8,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// Subtitle
                    Text(
                      banner.subtitle,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        height: 28 / 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
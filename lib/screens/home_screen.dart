import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/banner_model.dart';
import 'package:grocers/models/product_model.dart';

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

class GrocersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;

  const GrocersAppBar({
    super.key,
    this.onMenuTap,
    this.onSearchTap,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2D5A27);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCF8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
        border: const Border(
          bottom: BorderSide(
            color: Color(0x33DCFCE7),
            width: 1,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A2D5A27),
            offset: Offset(0, 8),
            blurRadius: 30,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Menu
              GestureDetector(
                onTap: onMenuTap,
                child: Icon(
                  Icons.menu,
                  color: green,
                  size: 24.sp,
                ),
              ),

              /// Title
              Text(
                "Grocers",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  height: 32 / 24,
                  letterSpacing: -0.6,
                  color: green,
                ),
              ),

              /// Actions
              Row(
                children: [
                  GestureDetector(
                    onTap: onSearchTap,
                    child: Icon(
                      Icons.search,
                      color: green,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: const BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF154212);
    const lightText = Color(0xFF42493E);
    const priceColor = Color(0xFF934B00);

    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A2D5A27),
            offset: Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          /// IMAGE SECTION
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.r),
                ),
                child: Image.asset(
                  widget.product.imagePath,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// FRESH TAG
              if (widget.product.isFresh)
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.eco_outlined,
                          size: 14.sp,
                          color: green,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "FRESH",
                          style: GoogleFonts.lexend(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          /// BOTTOM SECTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAME
                Text(
                  widget.product.name,
                  style: GoogleFonts.lexend(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: lightText,
                  ),
                ),

                SizedBox(height: 4.h),

                /// PRICE + ACTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${widget.product.price.toStringAsFixed(2)} / kg",
                      style: GoogleFonts.lexend(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: priceColor,
                      ),
                    ),

                    /// ACTION BUTTON
                    _buildActionButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    const green = Color(0xFF154212);

    if (quantity == 0) {
      return GestureDetector(
        onTap: () {
          setState(() => quantity = 1);
        },
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: const BoxDecoration(
            color: green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (quantity > 0) quantity--;
              });
            },
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 18.sp,
            ),
          ),

          SizedBox(width: 8.w),

          Text(
            quantity.toString(),
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(width: 8.w),

          GestureDetector(
            onTap: () {
              setState(() => quantity++);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
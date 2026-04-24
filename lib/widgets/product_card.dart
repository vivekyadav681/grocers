import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/product_model.dart';

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
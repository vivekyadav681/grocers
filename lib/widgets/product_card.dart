import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocers/models/product_model.dart';
import 'package:grocers/provider/cart_provider.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final quantity = cart[widget.product.name]?.quantity ?? 0;

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
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.eco_outlined, size: 14.sp, color: green),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                    Flexible(
                      child: Text(
                        "₹${widget.product.price.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lexend(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: priceColor,
                        ),
                      ),
                    ),

                    /// ACTION BUTTON
                    _buildActionButton(quantity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(int quantity) {
    const green = Color(0xFF154212);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: quantity == 0
          ? GestureDetector(
              key: const ValueKey('add_button'),
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: () {
                ref.read(cartProvider.notifier).addProduct(widget.product);
              },
              child: AnimatedScale(
                scale: _isPressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D5A27), Color(0xFF154212)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: green.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                ),
              ),
            )
          : Container(
              key: const ValueKey('quantity_selector'),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: green.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _circleIcon(Icons.remove, () {
                    ref
                        .read(cartProvider.notifier)
                        .removeProduct(widget.product);
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      quantity.toString(),
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _circleIcon(Icons.add, () {
                    ref.read(cartProvider.notifier).addProduct(widget.product);
                  }),
                ],
              ),
            ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16.sp),
      ),
    );
  }
}

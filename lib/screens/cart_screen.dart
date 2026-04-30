import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    
    const green = Color(0xFF154212);
    const lightText = Color(0xFF42493E);
    const priceColor = Color(0xFF934B00);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F0),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80.sp, color: const Color(0xFF2D5A27).withOpacity(0.5)),
                  SizedBox(height: 16.h),
                  Text(
                    "Your Cart is Empty",
                    style: GoogleFonts.lexend(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Add some delicious groceries to your cart!",
                    style: GoogleFonts.lexend(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: lightText,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: cart.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final item = cart.values.elementAt(index);
                      final product = item.product;

                      return Dismissible(
                        key: ValueKey(product.name),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          cartNotifier.deleteProduct(product);
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A2D5A27),
                              offset: Offset(0, 8),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                product.imagePath,
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lexend(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: lightText,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "₹${product.price.toStringAsFixed(2)}",
                                    style: GoogleFonts.lexend(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: priceColor,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F6F2),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _circleIcon(Icons.remove, () {
                                          cartNotifier.removeProduct(product);
                                        }, color: green),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: GoogleFonts.lexend(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: green,
                                            ),
                                          ),
                                        ),
                                        _circleIcon(Icons.add, () {
                                          cartNotifier.addProduct(product);
                                        }, color: green),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cartNotifier.deleteProduct(product);
                                  },
                                  child: Icon(Icons.close, color: Colors.red.shade300, size: 24.sp),
                                ),
                                SizedBox(height: 24.h),
                                Text(
                                  "₹${(product.price * item.quantity).toStringAsFixed(2)}",
                                  style: GoogleFonts.lexend(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  ),
                ),
                _buildBottomCheckoutBar(context, ref, green),
              ],
            ),
    );
  }

  Widget _buildBottomCheckoutBar(BuildContext context, WidgetRef ref, Color green) {
    final cartNotifier = ref.read(cartProvider.notifier);
    
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 100.h), // padding bottom for navbar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F2D5A27),
            offset: Offset(0, -8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total (${cartNotifier.totalItems} items)",
                style: GoogleFonts.lexend(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF42493E),
                ),
              ),
              Text(
                "₹${cartNotifier.totalAmount.toStringAsFixed(2)}",
                style: GoogleFonts.lexend(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: green,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                // Checkout logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Proceed to Checkout",
                style: GoogleFonts.lexend(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap, {required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 16.sp),
      ),
    );
  }
}

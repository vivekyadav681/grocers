import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/product_model.dart';
import 'package:grocers/data/mock_products.dart';
import 'package:grocers/provider/cart_provider.dart';
import 'package:grocers/widgets/product_card.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const green = Color(0xFF154212);
    final cart = ref.watch(cartProvider);
    final quantity = cart[product.name]?.quantity ?? 0;
    
    // Generate some random products for the bottom section
    final random = Random();
    final randomProducts = List<ProductModel>.from(mockProducts)
      ..shuffle(random);
    final recommendations = randomProducts.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: green),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 350.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A2D5A27),
                    offset: Offset(0, 8),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            
            // Product Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: GoogleFonts.lexend(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: green,
                            height: 1.2,
                          ),
                        ),
                      ),
                      if (product.isFresh)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: green.withOpacity(0.1),
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
                                  fontWeight: FontWeight.w600,
                                  color: green,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "₹${product.price.toStringAsFixed(2)}",
                    style: GoogleFonts.lexend(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF934B00),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Description",
                    style: GoogleFonts.lexend(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description,
                    style: GoogleFonts.lexend(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF42493E),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  
                  // Add to Cart Section
                  Row(
                    children: [
                      if (quantity > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              _circleIcon(Icons.remove, () {
                                ref.read(cartProvider.notifier).removeProduct(product);
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  quantity.toString(),
                                  style: GoogleFonts.lexend(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _circleIcon(Icons.add, () {
                                ref.read(cartProvider.notifier).addProduct(product);
                              }),
                            ],
                          ),
                        )
                      else
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).addProduct(product);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              elevation: 8,
                              shadowColor: green.withOpacity(0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  "Add to Cart",
                                  style: GoogleFonts.lexend(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: 40.h),
                  Text(
                    "You Might Also Like",
                    style: GoogleFonts.lexend(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
            
            // Random Products Horizontal List
            SizedBox(
              height: 260.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                scrollDirection: Axis.horizontal,
                itemCount: recommendations.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return ProductCard(product: recommendations[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}

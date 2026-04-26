import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/banner_model.dart';
import 'package:grocers/models/category_model.dart';
import 'package:grocers/models/product_model.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // matches your design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  /// MOCK DATA
  final banners = [
    BannerModel(
      title: "Harvest Up to 30% Off",
      subtitle: "Experience the taste of peak-season freshness",
      imagePath: "assets/images/harvest.png",
    ),
  ];

  final vegetables = [
    ProductModel(
      name: "Bell Peppers",
      price: 2.99,
      imagePath: "assets/images/pepper.png",
      isFresh: true,
    ),
    ProductModel(
      name: "Garden Carrots",
      price: 1.49,
      imagePath: "assets/images/carrots.png",
    ),
  ];

  final fruits = [
    ProductModel(
      name: "Gala Apples",
      price: 3.99,
      imagePath: "assets/images/apple.png",
    ),
    ProductModel(
      name: "Cavendish Banana",
      price: 0.99,
      imagePath: "assets/images/banana.png",
    ),
  ];

  final categories = [
    CategoryModel(title: "Daily Dairy", imagePath: "assets/images/milk.png"),
    CategoryModel(title: "Snacks", imagePath: "assets/images/snacks.png"),
    CategoryModel(title: "Bakery", imagePath: "assets/images/bread.png"),
    CategoryModel(title: "Exotic Fruits", imagePath: "assets/images/exotic.png"),
  ];

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF154212);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GrocersAppBar(),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
      ),

      body: Stack(
        children: [
          /// MAIN CONTENT
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Banner
                BannerSlide(banner: banners.first),

                /// Vegetables Section
                _buildSectionHeader(
                  title: "Fresh Vegetables",
                  icon: Icons.eco_outlined,
                  iconColor: const Color(0xFF415800),
                ),

                SizedBox(height: 12.h),

                _horizontalProducts(vegetables),

                /// Fruits Section
                _buildSectionHeader(
                  title: "Organic Fruits",
                  icon: Icons.apple,
                  iconColor: const Color(0xFF934B00),
                ),

                SizedBox(height: 12.h),

                _horizontalProducts(fruits),

                /// Categories
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Explore Daily Dairy & More",
                    style: GoogleFonts.lexend(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: green,
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                _categoryGrid(),
              ],
            ),
          ),

          /// FLOATING CART BUTTON
          Positioned(
            right: 20.w,
            bottom: 100.h,
            child: Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2D5A27),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D2D5A27),
                    offset: Offset(0, 12),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: const Color(0xFF9DD090),
                size: 28.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION HEADER
  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF154212),
                ),
              ),
              SizedBox(width: 6.w),
              Icon(icon, size: 16.sp, color: iconColor),
            ],
          ),
          Text(
            "View All",
            style: GoogleFonts.lexend(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF154212),
            ),
          ),
        ],
      ),
    );
  }

  /// HORIZONTAL PRODUCT LIST
  Widget _horizontalProducts(List<ProductModel> products) {
    return SizedBox(
      height: 260.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }

  /// CATEGORY GRID
  Widget _categoryGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}
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



class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 163.w,
        height: 163.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: Stack(
            children: [
              /// Background Image
              Positioned.fill(
                child: Image.asset(
                  category.imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              /// Dark overlay for text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),

              /// Title
              Positioned(
                left: 12.w,
                bottom: 12.h,
                child: Text(
                  category.title,
                  style: GoogleFonts.lexend(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    NavItem(icon: Icons.home_outlined, label: "Home"),
    NavItem(icon: Icons.grid_view_rounded, label: "Categories"),
    NavItem(icon: Icons.shopping_bag_outlined, label: "Cart"),
    NavItem(icon: Icons.person_outline, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2D5A27);
    const grey = Color(0xFFA8A29E);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.r),
        topRight: Radius.circular(32.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 84.h,
          padding: EdgeInsets.fromLTRB(38.w, 12.h, 38.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            border: const Border(
              top: BorderSide(
                color: Color(0xFFF0FDF4),
                width: 1,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F2D5A27),
                offset: Offset(0, -8),
                blurRadius: 24,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == currentIndex;

              return GestureDetector(
                onTap: () => onTap(index),
                child: _NavItemWidget(
                  item: item,
                  isSelected: isSelected,
                  green: green,
                  grey: grey,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final Color green;
  final Color grey;

  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.green,
    required this.grey,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0E7),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 18.sp,
              color: green,
            ),
            SizedBox(width: 6.w),
            Text(
              item.label,
              style: GoogleFonts.lexend(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                height: 16.5 / 11,
                color: green,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          size: 18.sp,
          color: grey,
        ),
        SizedBox(height: 4.h),
        Text(
          item.label,
          style: GoogleFonts.lexend(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            height: 16.5 / 11,
            color: grey,
          ),
        ),
      ],
    );
  }
}
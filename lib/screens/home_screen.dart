import 'dart:ui';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/banner_model.dart';
import 'package:grocers/models/category_model.dart';
import 'package:grocers/models/product_model.dart';
import 'package:grocers/data/mock_banners.dart';
import 'package:grocers/data/mock_categories.dart';
import 'package:grocers/data/mock_products.dart';
import 'package:grocers/widgets/custom_nav_bar.dart';
import 'package:grocers/widgets/product_card.dart';
import 'package:grocers/screens/cart_screen.dart';
import 'package:grocers/screens/search_screen.dart';
import 'package:grocers/provider/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  late final banners = mockBanners;
  late final vegetables = mockProducts.where((p) => p.category == Category.vegetable).toList();
  late final fruits = mockProducts.where((p) => p.category == Category.fruits).toList();
  late final snacks = mockProducts.where((p) => p.category == Category.snack).toList();
  late final beverages = mockProducts.where((p) => p.category == Category.beverages).toList();
  late final dairy = mockProducts.where((p) => p.category == Category.dairy).toList();
  late final home = mockProducts.where((p) => p.category == Category.home).toList();
  late final electronics = mockProducts.where((p) => p.category == Category.electronics).toList();
  
  late final categories = mockCategories;

  final PageController _bannerController = PageController();
  late Timer _timer;
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentBannerIndex < banners.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF154212);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F0),
      appBar: GrocersAppBar(
        onSearchTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
        },
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(animation);
          
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
        child: _buildCurrentScreen(currentIndex),
      ),
    );
  }

  Widget _buildCurrentScreen(int index) {
    switch (index) {
      case 0:
        return _homeContent();
      case 1:
        return _placeholderScreen("Categories", Icons.grid_view_rounded);
      case 2:
        return const CartScreen();
      case 3:
        return _placeholderScreen("Profile", Icons.person_outline);
      default:
        return _homeContent();
    }
  }

  Widget _placeholderScreen(String title, IconData icon) {
    return Center(
      key: ValueKey(title),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64.sp, color: const Color(0xFF2D5A27).withOpacity(0.5)),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF154212),
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeContent() {
    const green = Color(0xFF154212);
    return Stack(
      key: const ValueKey('home_content'),
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.h,
                child: PageView.builder(
                  controller: _bannerController,
                  onPageChanged: (index) {
                    _currentBannerIndex = index;
                  },
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return BannerSlide(banner: banners[index]);
                  },
                ),
              ),
              _buildSectionHeader(
                title: "Fresh Vegetables",
                icon: Icons.eco_outlined,
                iconColor: const Color(0xFF415800),
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(vegetables),
              _buildSectionHeader(
                title: "Organic Fruits",
                icon: Icons.apple,
                iconColor: const Color(0xFF934B00),
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(fruits),
              _buildSectionHeader(
                title: "Daily Dairy",
                icon: Icons.water_drop,
                iconColor: Colors.blueAccent,
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(dairy),
              _buildSectionHeader(
                title: "Tasty Snacks",
                icon: Icons.fastfood,
                iconColor: Colors.orange,
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(snacks),
              _buildSectionHeader(
                title: "Beverages",
                icon: Icons.local_cafe,
                iconColor: Colors.brown,
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(beverages),
              _buildSectionHeader(
                title: "Home Essentials",
                icon: Icons.home,
                iconColor: Colors.teal,
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(home),
              _buildSectionHeader(
                title: "Electronics Mega Sale",
                icon: Icons.electrical_services,
                iconColor: Colors.deepPurple,
              ),
              SizedBox(height: 12.h),
              _horizontalProducts(electronics),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Text(
                  "Explore Categories",
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
        Positioned(
          right: 20.w,
          bottom: 20.h,
          child: Consumer(
            builder: (context, ref, child) {
              final cart = ref.watch(cartProvider);
              int totalItems = 0;
              cart.forEach((_, item) => totalItems += item.quantity);
              
              return GestureDetector(
                onTap: () => setState(() => currentIndex = 2),
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: const Color(0xFF9DD090),
                        size: 28.sp,
                      ),
                      if (totalItems > 0)
                        Positioned(
                          right: 12.w,
                          top: 12.h,
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              totalItems.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// SECTION HEADER
  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
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
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            child: Text(
              "View All",
              style: GoogleFonts.lexend(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2D5A27),
              ),
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

  const BannerSlide({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x142D5A27),
            offset: Offset(0, 24),
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
              child: Image.asset(banner.imagePath, fit: BoxFit.cover),
            ),

            /// Overlay for readability
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
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
                        fontSize: 32.sp,
                        height: 1.2,
                        letterSpacing: -0.5,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// Subtitle
                    Text(
                      banner.subtitle,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 1.4,
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
          bottom: BorderSide(color: Color(0x33DCFCE7), width: 1),
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
                child: Icon(Icons.menu, color: green, size: 24.sp),
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
                    child: Icon(Icons.search, color: green, size: 24.sp),
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

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 163.w,
        height: 163.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: Stack(
            children: [
              /// Background Image
              Positioned.fill(
                child: Image.asset(category.imagePath, fit: BoxFit.cover),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocers/models/product_model.dart';
import 'package:grocers/data/mock_products.dart';
import 'package:grocers/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = mockProducts;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = mockProducts.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF154212);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFCF8),
        elevation: 0,
        iconTheme: const IconThemeData(color: green),
        title: Text(
          "All Products",
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: green,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A2D5A27),
                    offset: Offset(0, 8),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search groceries...",
                  hintStyle: GoogleFonts.lexend(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search, color: green),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _filteredProducts.isEmpty
          ? Center(
              child: Text(
                "No products found.",
                style: GoogleFonts.lexend(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.65, // Adjust for product card height
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: _filteredProducts[index]);
              },
            ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
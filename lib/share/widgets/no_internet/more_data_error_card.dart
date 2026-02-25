// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
//
// class MoreDataErrorCard extends StatelessWidget {
//   const MoreDataErrorCard({
//     super.key,
//     required this.onTap,
//     this.message,
//     this.icon,
//     this.iconColor,
//     this.textColor,
//     this.padding,
//     this.iconSize ,
//   });
//
//   final VoidCallback onTap;
//   final String? message;
//   final IconData? icon;
//   final Color? iconColor;
//   final Color? textColor;
//   final EdgeInsetsGeometry? padding;
//   final double? iconSize;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Padding(
//       padding: padding ??  EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8), horizontal: ResponsiveHelper.width(10)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: onTap,
//         splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//         child: Container(
//           padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(10), vertical: ResponsiveHelper.height(8)),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
//             color: Theme.of(context).colorScheme.surface,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon ?? Icons.refresh_rounded,
//                 size: iconSize??ResponsiveHelper.height(20),
//                 color: iconColor ?? theme.colorScheme.primary,
//               ),
//                Gap(ResponsiveHelper.width(6)),
//               Flexible(
//                 child: Text(
//                   message ?? "Something went wrong. Tap to try again",
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     fontSize: ResponsiveHelper.fontSize(12),
//                     color: textColor ?? theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

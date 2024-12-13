import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/font_size.dart';

class AppCachesImages {
  static Widget cachedImages(String? images) {
    // Provide a default image URL or a placeholder image
    String imageUrl = images != null ? AppApiUtils.imageUrl + images : 'path/to/default/image';

    return Container(
      height: AppFontSize.font60,
      width: AppFontSize.font60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppFontSize.font30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppFontSize.font30),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

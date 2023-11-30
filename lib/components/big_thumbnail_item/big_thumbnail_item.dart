import 'package:flutter/material.dart';
import 'package:sleeptube/utils/color.dart';

class BigThumbnailItem extends StatelessWidget {
  final String id;
  final String? title;
  final String? thumbnailUrl;
  final String? author;
  final void Function(String id)? onTap;
  final bool? isPlaying;

  const BigThumbnailItem(
      {super.key,
      required this.id,
      this.title,
      this.author,
      this.thumbnailUrl,
      this.onTap,
      this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(id),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            thumbnailUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        thumbnailUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 12,
            ),
            Text(
              title ?? "",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isPlaying == true ? COLOR_A : Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              author ?? "",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

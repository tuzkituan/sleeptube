import 'package:flutter/material.dart';
import 'package:sleeptube/utils/color.dart';
import 'package:sleeptube/utils/constants.dart';

class VideoItem extends StatelessWidget {
  final String id;
  final String? title;
  final String? thumbnailUrl;
  final String? author;
  final void Function(String id)? onTap;
  final bool? isPlaying;

  const VideoItem(
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
        padding: const EdgeInsets.symmetric(
          horizontal: MyConst.CONTAINER_PADDING / 2,
          vertical: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isPlaying == true
                ? COLOR_C.withOpacity(0.4)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 8.0,
            bottom: 8.0,
            right: 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    thumbnailUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(2.0),
                            child: Image.network(
                              thumbnailUrl!,
                              height: 44,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(
                            height: 44,
                            width: 60,
                          ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isPlaying == true ? COLOR_A : Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            author ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              IconButton(
                iconSize: 22,
                icon: const Icon(
                  Icons.more_vert,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

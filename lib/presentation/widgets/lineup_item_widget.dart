import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class LineupItemWidget extends StatelessWidget {
  const LineupItemWidget({
    super.key,
    required this.lineupItem,
  });

  final LineupItemModel lineupItem;

  final url =
      'https://fastly.picsum.photos/id/202/1000/1000.jpg?hmac=06EOZKISNxCoPtI2ikLkm3LkVJ7UaHiPTIXwQ_-1L1U';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lineupItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                lineupItem.author,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        ExtendedImage.network(url),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(lineupItem.description),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

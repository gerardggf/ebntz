part of '../filter_posts_view.dart';

String _getOrderRoutesText(OrderPostsBy orderBy) {
  switch (orderBy) {
    case OrderPostsBy.creationDate:
      return texts.global.creationDate;
    case OrderPostsBy.firstDate:
      return texts.global.eventDate;
    case OrderPostsBy.name:
      return texts.global.name;
    case OrderPostsBy.location:
      return texts.global.location;
    default:
      return texts.global.creationDate;
  }
}

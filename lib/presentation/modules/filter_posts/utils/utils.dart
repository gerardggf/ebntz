part of '../filter_posts_view.dart';

String _getOrderRoutesText(OrderPostsBy orderBy) {
  switch (orderBy) {
    case OrderPostsBy.creationDate:
      return 'Fecha de creación';
    case OrderPostsBy.firstDate:
      return 'Fecha evento';
    case OrderPostsBy.name:
      return 'Nombre';
    case OrderPostsBy.location:
      return 'Ubicación';
    default:
      return 'Fecha de creación';
  }
}

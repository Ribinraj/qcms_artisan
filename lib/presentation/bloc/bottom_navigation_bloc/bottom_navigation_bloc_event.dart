part of 'bottom_navigation_bloc_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}
final class NavigateToPageEvent extends BottomNavigationEvent {
  final int pageIndex;
  NavigateToPageEvent({required this.pageIndex});
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_cubit.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_state.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/common/widgets/progress_indicator.dart';
import 'package:key_test_project/offices/presentation/widgets/offices_list_widget.dart';
import 'package:key_test_project/places/presentation/pages/bookings_screen.dart';

class HomePage extends StatelessWidget {
  
  HomePage({Key? key}) : super(key: key);


  final _officesScreen = GlobalKey<NavigatorState>();
  final _bookingsScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    context.read<NavbarCubit>().selectTab(0);
    return BlocBuilder<NavbarCubit, NavbarState>(builder: (context, state) {
      int currentIndex = 0;
      if (state is NavbarLoadingState) {
        return _loadingIndicator();
      } else if (state is NavbarChangedState) {
        currentIndex = state.currentTab;
      }
        return Scaffold(

            body: IndexedStack(
              index: currentIndex,
              children: <Widget>[
                Navigator(
                  key: _officesScreen,
                  onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route,
                    builder: (context) => const OfficesList(),
                  ),
                ),


                Navigator(
                  key: _bookingsScreen,
                  onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route,
                    builder: (context) => const BookingsPage(),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.mainBackground,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (val) => _onTap(val, currentIndex, context),
              items: const [
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ));
      }
    );
  }

  void _onTap(int val, int currentIndex, BuildContext context) {
    if (currentIndex == val) {
      switch (val) {
        case 0:
          _officesScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          _bookingsScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      context.read<NavbarCubit>().selectTab(val);
    }
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: AppProgressIndicator(),
      ),
    );
  }
}

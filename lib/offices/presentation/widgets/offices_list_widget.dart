import 'package:key_test_project/common/widgets/progress_indicator.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/offices/presentation/bloc/offices_list_cubit/offices_list_cubit.dart';
import 'package:key_test_project/offices/presentation/bloc/offices_list_cubit/offices_list_state.dart';
import 'package:key_test_project/offices/presentation/widgets/offices_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfficesList extends StatelessWidget {

  const OfficesList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронирование места в офисе'),
        centerTitle: true,
      ),
      body: BlocBuilder<OfficesListCubit, OfficeState>(
          builder: (context, state) {
        List<OfficeEntity> offices = [];
        if (state is OfficeLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is OfficeLoadingState) {
          offices = state.oldOfficesList;
        } else if (state is OfficeErrorState) {
          return Text(state.message);
        } else if (state is OfficeLoadedState) {
          offices = state.officesList;
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OfficeCard(office: offices[index]),
              );
          },
          itemCount: offices.length,
        );
      }),
    );
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

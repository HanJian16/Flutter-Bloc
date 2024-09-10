import 'package:blocs_app/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocsWithBlocsScreen extends StatelessWidget {
  const BlocsWithBlocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historicLocationState = context.watch<HistoricLocationBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicaciones: ${historicLocationState.howManyLocations}'),
      ),
      body: ListView.builder(
        itemCount: historicLocationState.howManyLocations,
        itemBuilder: (context, index) {
          final (lat, lon) = historicLocationState.locations[index];
          return Text('Ubicación: $lat, $lon');
        },
      ),
    );
  }
}

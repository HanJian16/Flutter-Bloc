import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocs_app/config/config.dart';
import 'package:blocs_app/presentation/blocs/blocs.dart';

class CubitScreen extends StatelessWidget {
  const CubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* Esta es la forma mas simple de llamar al cubit y tener acceso a el desde
    //* todo el widget, pero es un poco menos eficiente que su contrapartem pues
    //* debe redibujar todo el build cuando el cubit cambie.
    //? final usernameCubit = context.watch<UserNameCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit'),
      ),
      body: Center(
        //* Aqui estamos usando el BlocBuilder para actualizar el estado del cubit
        //* en vez de usar el watch, este metodo es mas eficiente pero tiene sus contras.
        child: BlocBuilder<UserNameCubit, String>(
          //* Aqui estamos usando el buildWhen para actualizar el estado
          //* del cubit cuando cambie, este parametro es opcional.
          buildWhen: (previous, current) => current != previous,
          builder: (context, state) => Text(state),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //* Esta es la forma de llamar al cubit cuando no se tiene acceso a el
          //* desde todo el widget.
          context
              .read<UserNameCubit>()
              .setUserName(RandomGenerator.getRandomName());

          //* Aqui estamos llamando al cubit directamente para actualizar el
          //* estado cuando tenemos acceso a el desde todo el widget y no con el
          //* método del BlocBuilder.
          //? usernameCubit.setUserName(RandomGenerator.getRandomName());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

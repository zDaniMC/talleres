import 'package:go_router/go_router.dart';
import '../views/dog_list_view.dart';
import '../views/dog_detail_view.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'listado',
      path: '/',
      builder: (context, state) => const DogListView(),
    ),
    GoRoute(
      name: 'detalle',
      path: '/detalle/:breed',
      builder: (context, state) {
        final breed = state.params['breed']!;
        return DogDetailView(breed: breed);
      },
    ),
  ],
);

enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  error(name: 'error'),
  loading(name: 'loading'),
  smallError(name: 'small_error'),
  homeScreen(name: 'HomeScreen'),
  globe(name:'globe');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}

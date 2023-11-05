import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}


enum City {
  haifa,
  paris,
  tokyo,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.haifa: '💨',
      City.paris: '🌧️',
      City.tokyo: '❄️',
    }[city]!,
  );
}

// well be CHANGED by the ui
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);
const unknownWeatherEmoji = '🤷‍♂️';

// ui READS this
final weatherProvider = FutureProvider<WeatherEmoji>((ref) async {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return await getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("WEATHER"),
      ),
      body: Column(
        children: [
          currentWeather.when(
              data: (String data) => Text(
                    data,
                    style: const TextStyle(fontSize: 40.0),
                  ),
              error: (_, __) => const Text('error 🥲'),
              loading: () => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (BuildContext context, int index) {
                final city = City.values[index];
                final bool isSelected =
                    (city == ref.watch(currentCityProvider));
                return ListTile(
                  title: Text(
                    city.toString(),
                  ),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () =>
                      ref.read(currentCityProvider.notifier).state = city,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
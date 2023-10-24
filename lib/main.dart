import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafinoonoo/data.dart';
import 'package:kafinoonoo/widget/inputFeild.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kafinoonoo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//dart run build_runner watch
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.9);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var words = ref.watch(dataProvider) as List;
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    InputFieldWidget(
                      callBackFunction: (ValueKey) => ref
                          .read(dataProvider.notifier)
                          .filterEnglish(ValueKey),
                      hintText: "English",
                    ),
                    InputFieldWidget(
                      callBackFunction: (ValueKey) => ref
                          .read(dataProvider.notifier)
                          .filterKafinoonoo(ValueKey),
                      hintText: "Kafinoonoo",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('favorites').listenable(),
                  builder: (context, box, child) {
                    return ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final isFavorite = box.get(index) != null;
                        return Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                onPressed: () => speak(words[index]['name']),
                                icon: const Icon(
                                  Icons.volume_up,
                                  size: 30,
                                ),
                              ),
                              title: Text(words[index]['name']),
                              subtitle: Text(words[index]['country']),
                              trailing: IconButton(
                                  onPressed: () async {
                                    if (isFavorite) {
                                      await box.delete(index);
                                    } else {
                                      await box.put(
                                          index, words[index]['name']);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 30,
                                    color: Colors.red,
                                  )),
                            ),
                            Divider(
                              height: 0.2,
                              thickness: 1,
                              color: Colors.grey[500],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

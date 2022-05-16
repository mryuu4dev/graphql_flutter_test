import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_test/components/export.dart';
import 'package:graphql_flutter_test/configs/export.dart';
import 'package:graphql_flutter_test/models/export.dart';
import 'package:graphql_flutter_test/query_document_provider.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GraphQLClient client = GraphQLClient(
    link: HttpLink(
      dotenv.env['HASURA_GRAPHQL_ENDPOINT']!,
      defaultHeaders: <String, String>{
        "x-hasura-admin-secret":
            dotenv.env['HASURA_GRAPHQL_ADMIN_SECRET']!,
      },
    ),
    cache: GraphQLCache(),
  );
  late final ValueNotifier<GraphQLClient> clientNotifier =
      ValueNotifier<GraphQLClient>(client);
  
  final queries = MusicMateQueries();
  
  @override
  Widget build(BuildContext context) {
    return QueriesDocumentProvider(
      queries: queries,
      child: GraphQLProvider(
        client: clientNotifier,
        child: MaterialApp(
          title: 'Music Mates',
          home: const GetStartedScreen(),
          routes: {
            Routes.home: (context) => const HomeScreen(),
            Routes.selectArtist: (context) => const SelectArtistScreen(),
          },
        ),
      ),
    );
  }
}

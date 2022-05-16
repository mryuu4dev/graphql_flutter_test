import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_test/configs/export.dart';
import 'package:graphql_flutter_test/common/export.dart';
import 'package:graphql_flutter_test/models/export.dart';
import 'package:graphql_flutter_test/query_document_provider.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final googleSignin = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
              width: 120,
              height: 120,
            ),
            AppSpacing.v24,
            Mutation(
              options: MutationOptions(
                document: gql(context.queries.createAccount()),
                onCompleted: (data) => _onCompleted(data, context),
              ), 
              builder: (RunMutation runMutation, QueryResult? result) {
                if (result != null) {
                  if (result.isLoading) {
                    return const LoadingSpinner();
                  }
                  if (result.hasException) {
                    context.showError(
                      ErrorModel.fromGraphError(
                        result.exception?.graphqlErrors ?? [],
                      ),
                    );
                  }
                }
                return GoogleButton(
                  onPressed: () => _googleButtonPressed(context, runMutation),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onCompleted(data, BuildContext context) {
    final favouriteArtists = data['insert_users_one']['user_artists'];

    final bool hasSelectedArtist =
        favouriteArtists != null && favouriteArtists.isNotEmpty;

    Navigator.popAndPushNamed(
      context,
      hasSelectedArtist ? Routes.home : Routes.selectArtist,
    );
  }

  Future<void> _googleButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    final googleUser = await googleSignin.signIn();

    if (googleUser != null) {
      context.cacheGoogleId(googleUser.id);

      runMutation({
        "object": {
          "name": googleUser.displayName,
          "google_id": googleUser.id,
          "image_url": googleUser.photoUrl,
        }
      });
    }
  }
}

import 'dart:convert';

import 'package:graphql_bloc/models/User.dart';
import 'package:graphql_bloc/utils/storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_bloc/graphql/mutation/mutations.dart' as mutations;

class UserRepository {
  final GraphQLClient client;

  UserRepository(this.client) : assert(client != null);

  Future<User> authenticateUser(username, password) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.Login),
      variables: <String, String>{
        'username': username,
        'password': password,
      },
    );

    print('mutate opstions ==== ${_options.operationName}');

    var result = await client.mutate(_options);
    if (result.hasException) {
      print("error ====== ${result.exception.graphqlErrors[0].message}");
      throw result.exception.graphqlErrors[0].message;
    } else {
      return User.fromJson(result.data.data['action']);
    }
  }

  Future<bool> deleteUserInfo() async {
    return Storage().clearAll();
  }

  Future<void> persistUserInfo(User user) async {
    return Storage().setUserInfo(user);
  }

  Future<User> getUserInfo() async {
    return Storage().getUserInfo();
  }
}

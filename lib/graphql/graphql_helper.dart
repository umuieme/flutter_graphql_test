import 'package:graphql_bloc/utils/constant.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlHelper {
  GraphQLClient _client;
  static final GraphqlHelper _singleton = new GraphqlHelper._internal();

  factory GraphqlHelper() {
    return _singleton;
  }

  GraphqlHelper._internal() {
    _setup();
  }

  _setup() {
    final HttpLink _httpLink = HttpLink(
      uri: Api.BASE_URL,
    );

    final AuthLink _authLink = AuthLink(
        // getToken: () => 'Bearer ',
        );

    final Link _link = _authLink.concat(_httpLink);

    _client = GraphQLClient(
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
      link: _httpLink,
    );
  }

  GraphQLClient get grqphqlClient => _client;
}

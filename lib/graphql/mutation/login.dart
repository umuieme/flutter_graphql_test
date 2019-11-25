const String Login = r'''
mutation login($username: String!, $password: String!) {
      action: login(
        username: $username,
        password: $password,
      ) {
        fullname, username, password
      }
    }
''';

// String getLogin(username, password){
//   return '''
//     mutation login($username: String!, $password: String!){
//       login(
//         username: "admin",
//         password: "secret",
//       ) {
//         fullname, username, password
//       }
//     }
//   ''';
// }
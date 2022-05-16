import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorModel {
  final String error;

  ErrorModel.fromString(String error_) : error = error_;
  ErrorModel.fromGraphError(List<GraphQLError> errors)
      : error = errors.map((elem) => "${elem.message}, ").toList().toString();
}

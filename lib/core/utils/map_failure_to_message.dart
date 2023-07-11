
import '../errors/failures.dart';
import '../strings/failures.dart';

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return failure.message;
  } else if (failure is OfflineFailure) {
    return OFFLINE_FAILURE_MESSAGE;
  } else {
    return "Unexpected Error , Please try again later .";
  }
}

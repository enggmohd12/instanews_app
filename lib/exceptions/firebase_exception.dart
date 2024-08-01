// Login Exception
class InvalidCredentialAuthException implements Exception{}

class WrongPasswordAuthException implements Exception{}

class TooManyRequestAuthException implements Exception{}

class UserNotFoundException implements Exception{}

// Register Exception

class WeakPasswordAuthException implements Exception{}

class EmailAlreadyInUseAuthException implements Exception{}

class InvalidEmailAuthException implements Exception{}

// generic Exception

class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}


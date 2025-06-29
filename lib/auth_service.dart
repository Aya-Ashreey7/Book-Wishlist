String? currentUserEmail;

bool isLoggedIn() => currentUserEmail != null;

void loginUser(String email) {
  currentUserEmail = email;
}

void logoutUser() {
  currentUserEmail = null;
}

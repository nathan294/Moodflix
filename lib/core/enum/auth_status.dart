enum AuthStatus {
  // This indicates that user was already created in our database so he will be redirected to home screen.
  returningUser,

// This indicates that user has been created in our database so he will be redirected to onboarding screen.
  newUser,
}

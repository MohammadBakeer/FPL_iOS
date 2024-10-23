import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    // Email Input Field
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.purple)

                        TextField("Enter your email", text: $email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }

                    // Password Input Field
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.purple)

                        SecureField("Enter your password", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                    
                    // Confirm Password Input Field
                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                            .font(.headline)
                            .foregroundColor(.purple)

                        SecureField("Confirm your password", text: $confirmPassword)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }

                    // Submit Button
                    Button(action: {
                        signUp()
                    }) {
                        Text("Sign up")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Information"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
                Spacer()
            }
            
            Text("Create your account")
                .font(.system(size: 20))
                .foregroundColor(.purple)
                .padding(.top, 40)
                .padding(.leading, 20)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // Function to handle sign up
    private func signUp() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        let newUser = UserManager.UserCredentials(email: email, password: password)
        UserManager.saveUser(newUser)
        alertMessage = "Account created successfully!"
        showAlert = true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

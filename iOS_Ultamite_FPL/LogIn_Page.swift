import SwiftUI

struct LogIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
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

                    // Submit Button
                    Button(action: {
                        logIn()
                    }) {
                        Text("Log in")
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
            
            Text("Log In")
                .font(.system(size: 20))
                .foregroundColor(.purple)
                .padding(.top, 40)
                .padding(.leading, 20)
        }
        .padding()
        .background(Color(.systemGray6))
    }

    // Function to handle login
    private func logIn() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        if let savedUser = UserManager.getUser() {
            if savedUser.email == email && savedUser.password == password {
                alertMessage = "Logged in successfully!"
            } else {
                alertMessage = "Invalid email or password."
            }
        } else {
            alertMessage = "No account found. Please sign up."
        }
        showAlert = true
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}

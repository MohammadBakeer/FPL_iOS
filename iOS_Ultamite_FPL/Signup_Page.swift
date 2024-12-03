import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var teamName: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToContentView: Bool = false
    @State private var roundNum: Int? = nil
    
    @AppStorage("user_id") private var userId: Int? // Store user_id persistently

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
                            .autocapitalization(.none) // Prevent capitalization
                            .keyboardType(.emailAddress) // Optimize for email input
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }

                    // Team Name Input Field
                    VStack(alignment: .leading) {
                        Text("Team Name")
                            .font(.headline)
                            .foregroundColor(.purple)

                        TextField("Enter your team name", text: $teamName)
                            .autocapitalization(.none) // Prevent capitalization
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
                            .autocapitalization(.none) // Prevent capitalization
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
                            .autocapitalization(.none) // Prevent capitalization
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }

                    // Display the round number (if available)
                    if let roundNum = roundNum {
                        Text("Current Round: \(roundNum)")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .padding(.top, 10)
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
        .onAppear {
            fetchRoundNum()
        }
        .fullScreenCover(isPresented: $navigateToContentView) {
            ContentView() // Navigate to the next page
        }
    }

    // Function to fetch the round number
    private func fetchRoundNum() {
        RoundManager.shared.fetchRoundNum { round in
            DispatchQueue.main.async {
                self.roundNum = round
            }
        }
    }

    // Function to handle sign up
    private func signUp() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty || teamName.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        guard let roundNum = roundNum else {
            alertMessage = "Round number is not available. Please try again."
            showAlert = true
            return
        }

        let url = URL(string: "https://fpliosserver-production.up.railway.app/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
            "password": password,
            "teamName": teamName,
            "roundNum": roundNum
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    alertMessage = "Failed to connect to the server."
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                // Parse the user_id from the response
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let userId = responseData["user_id"] as? Int {
                    DispatchQueue.main.async {
                        self.userId = userId // Save user_id to AppStorage
                        navigateToContentView = true
                    }
                }
            } else {
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let serverMessage = responseData["message"] as? String {
                    DispatchQueue.main.async {
                        alertMessage = serverMessage
                        showAlert = true
                    }
                } else {
                    DispatchQueue.main.async {
                        alertMessage = "Sign up failed. Please try again."
                        showAlert = true
                    }
                }
            }
        }.resume()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

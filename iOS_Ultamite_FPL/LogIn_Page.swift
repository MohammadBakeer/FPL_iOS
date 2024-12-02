import SwiftUI

struct LogIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToContentView: Bool = false // State variable to navigate

    @AppStorage("user_id") private var userId: Int? // Store user_id in AppStorage

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
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never) // Prevent capitalization
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
                            .textInputAutocapitalization(.never) // Prevent capitalization
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
        .fullScreenCover(isPresented: $navigateToContentView) {
            ContentView() // Navigate to the next view
        }
    }

    // Function to handle login
    private func logIn() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        // Define the server URL
        guard let url = URL(string: "http://localhost:3000/auth/login") else {
            alertMessage = "Invalid server URL."
            showAlert = true
            return
        }

        // Prepare the request payload
        let payload: [String: Any] = ["email": email, "password": password]

        // Convert the payload to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
            alertMessage = "Failed to encode login details."
            showAlert = true
            return
        }

        // Create a POST request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Send the request using URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error connecting to the server: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }

            // Check the response status
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        alertMessage = "Server error: \(httpResponse.statusCode)"
                        showAlert = true
                    }
                    return
                }
            }

            // Parse the response
            if let data = data {
                do {
                    // Decode JSON response
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let message = json["message"] as? String {
                        DispatchQueue.main.async {
                            if let newUserId = json["user_id"] as? Int {
                                // Store the new user_id in AppStorage
                                userId = newUserId
                                navigateToContentView = true // Successful login
                            } else {
                                // Failed login
                                alertMessage = message
                                showAlert = true
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        alertMessage = "Failed to parse server response."
                        showAlert = true
                    }
                }
            }
        }.resume() // Start the network task
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}

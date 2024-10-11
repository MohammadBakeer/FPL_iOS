import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var teamName: String = ""
    @State private var playerCount: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background layer with centered form
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
                            .cornerRadius(8)  // Changed to 8 for a rectangular shape
                            .shadow(radius: 5)
                    }

                    // Team Name Input Field
                    VStack(alignment: .leading) {
                        Text("Team Name")
                            .font(.headline)
                            .foregroundColor(.purple)

                        TextField("Enter your team name", text: $teamName)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)  // Changed to 8 for a rectangular shape
                            .shadow(radius: 5)
                    }

                    // Password Input Field
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.purple)

                        TextField("Enter your password", text: $playerCount)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.default)  // Changed to default for password
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)  // Changed to 8 for a rectangular shape
                            .shadow(radius: 5)
                    }
                    
                    // Confirm Password Input Field
                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                            .font(.headline)
                            .foregroundColor(.purple)

                        TextField("Confirm your password", text: $playerCount)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.default)  // Changed to default for password
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)  // Changed to 8 for a rectangular shape
                            .shadow(radius: 5)
                    }

                    // Submit Button
                    Button(action: {
                        if email.isEmpty || teamName.isEmpty || playerCount.isEmpty {
                            showAlert = true
                        } else {
                            print("Email: \(email), Team Name: \(teamName), Player Count: \(playerCount)")
                        }
                    }) {
                        Text("Sign up")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)  // Changed to purple
                            .foregroundColor(.white)
                            .cornerRadius(8)  // Changed to 8 for a rectangular shape
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Missing Information"),
                              message: Text("Please fill in all fields."),
                              dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
                Spacer()
            }

            // Header positioned at the top left
           
            Text("Create your account")
                .font(.system(size: 20)) // This sets the font size to 24 points
                .foregroundColor(.purple)
                .padding(.top, 40)
                .padding(.leading, 20) // Adjust position as needed
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
//
//  Signup_Page.swift
//  iOS_Ultamite_FPL
//
//  Created by Hashirul Quadir on 10/11/24.
//


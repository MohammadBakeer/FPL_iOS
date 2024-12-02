import SwiftUI

struct ManageProfileView: View {
    @State private var teamName: String = "Poethunder"
    @State private var phoneNumber: String = "Poethunder"
    @State private var mailingAddress: String = "7388 Sanderson Way"
    @State private var showLogIn: Bool = false // State variable to present LogIn view
    @State private var showWelcomePage: Bool = false // State variable to present Welcome_Page

    var body: some View {
        VStack(spacing: 20) {
            // Header Section
            Text("Manage Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.black)
            
            // Team Name Field
            VStack(alignment: .leading) {
                Text("Team Name:")
                    .font(.headline)
                TextField("Enter team name", text: $teamName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            
            // Phone Number Field
            VStack(alignment: .leading) {
                Text("Phone Number:")
                    .font(.headline)
                TextField("Enter phone number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            
            // Mailing Address Field
            VStack(alignment: .leading) {
                Text("Mailing Address:")
                    .font(.headline)
                TextField("Enter mailing address", text: $mailingAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            
            // Buttons Section
            HStack(spacing: 20) {
                Button(action: {
                    showLogIn = true // Show LogIn view when clicked
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                Button(action: {
                    // Action for Save Changes
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Delete Account Button
            Button(action: {
                showWelcomePage = true // Show Welcome_Page when clicked
            }) {
                Text("Delete Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.9, green: 1.0, blue: 1.0))
        .ignoresSafeArea(edges: .bottom)
        .fullScreenCover(isPresented: $showLogIn) {
            LogIn() // Present the LogIn view
        }
        .fullScreenCover(isPresented: $showWelcomePage) {
            Welcome_Page() // Present the Welcome_Page
        }
    }
}

struct ManageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileView()
    }
}

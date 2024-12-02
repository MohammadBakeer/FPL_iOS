import SwiftUI

struct Welcome_Page: View {
    var body: some View {
        NavigationView { // Wrap the entire view in a NavigationView
            ZStack {
                // Background image
                Image("iphone background") // Background image
                    .resizable()
                    .scaledToFill() // Ensures the image fills the screen
                    .ignoresSafeArea() // Extends the image to the edges of the screen
                
                // Content on top of the images
                VStack {
                    Spacer()
                        .frame(height: 70)
                    
                    Text("Welcome to FPL!")
                        .font(.system(size: 38)) // Adjust the font size here
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Text("Build Your Winning XI")
                        .font(.system(size: 22)) // Adjust the font size here
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("Earn Points From Live Performances")
                        .font(.system(size: 22)) // Adjust the font size here
                        .foregroundColor(.white)
                    
                    // White outline image on top of the background
                    Image("whiteOutline-removebg-preview") // Make sure this name matches your asset's image name
                        .resizable()
                        .scaledToFit() // Scale to fit within the bounds while maintaining aspect ratio
                        .frame(width: 300, height: 300) // Adjust the frame size as needed
                        .padding(.bottom, 50) // Add bottom padding to adjust position
                    
                    Spacer()
                    
                    // Sign Up and Log In buttons
                    VStack(spacing: 10) { // Reduced spacing between the text and buttons
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Sign Up")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical, 10) // Adjust vertical padding to reduce thickness
                                .frame(width: 350) // Set the width of the button
                                .background(Color.purple) // Button background color
                                .cornerRadius(10) // Rounded corners
                        }
                        
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .padding(.bottom, 5) // Add some bottom padding for spacing

                        NavigationLink(destination: LogIn()) { // Navigate to the LogIn view
                            Text("Log In")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical, 10) // Adjust vertical padding to reduce thickness
                                .frame(width: 350) // Set the width of the button
                                .background(Color.purple) // Button background color
                                .cornerRadius(10) // Rounded corners
                        }
                    }
                    .padding(.bottom, 60) // Adjust bottom padding as needed
                }
            }
        }
    }
}

// Dummy views for navigation
struct SignUpView: View {
    var body: some View {
        Text("Sign Up Page")
            .font(.largeTitle)
            .padding()
    }
}

struct Welcome_Page_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_Page()
    }
}

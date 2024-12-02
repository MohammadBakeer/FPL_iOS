import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home_Page()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            FantasyPage()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Fantasy")
                }

            ManageProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.purple) // Optional: Customize tab bar color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

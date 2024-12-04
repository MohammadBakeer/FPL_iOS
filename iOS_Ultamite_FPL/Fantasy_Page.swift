import SwiftUI

struct FantasyPage: View {
    // State variables for managing leagues and popup visibility
    @State private var showCreateLeaguePopup: Bool = false
    @State private var leagueName: String = "Hashir’s HQ"
    @State private var pointsStartRound: String = "1"
    @State private var navigateToDetail: Bool = false
    @State private var navigateToJoinPage: Bool = false
    @State private var leagues: [String] = ["Hashir’s HQ", "Poethunder HQ"] // Example leagues
    @State private var joinedLeague: String? = nil // Track the league the user joined
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main content of the Fantasy Page
                VStack {
                    Text("Fantasy Leagues")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .foregroundColor(.black)
                    
                    // Buttons section
                    HStack(spacing: 20) {
                        Button(action: {
                            showCreateLeaguePopup = true // Show the popup when Create League is clicked
                        }) {
                            Text("Create League")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .cornerRadius(10)
                        }
                        
                        if joinedLeague == nil {
                            Button(action: {
                                navigateToJoinPage = true // Navigate to JoinLeaguePage when clicked
                            }) {
                                Text("Join League")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                        } else {
                            NavigationLink(destination: LeagueViewPage(leagueName: joinedLeague!, leagueLogo: "sportscourt", leagues: $leagues)) {
                                Text("View League")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Information section when no leagues are available
                    if leagues.isEmpty {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Create or Join your first private league")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.top, 30)
                            Text("Private Leagues with 50000 people or more can contact us to earn prizes for their league")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.vertical, 20)
                    } else {
                        // Display all leagues if available
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Current Leagues")
                                .font(.headline)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            ForEach(leagues, id: \.self) { league in
                                NavigationLink(destination: LeagueDetailPage(leagueName: league, leagues: $leagues)) {
                                    HStack {
                                        Image(systemName: "sportscourt")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 10)
                                        
                                        Text(league)
                                            .font(.headline)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    // Navigation Link to LeagueDetailPage
                    NavigationLink(destination: LeagueDetailPage(leagueName: leagueName, leagues: $leagues), isActive: $navigateToDetail) {
                        EmptyView()
                    }
                    
                    // Navigation Link to JoinLeaguePage
                    NavigationLink(destination: JoinLeaguePage(leagues: $leagues, joinedLeague: $joinedLeague), isActive: $navigateToJoinPage) {
                        EmptyView()
                    }
                }
                
                // Popup overlay for creating a league
                if showCreateLeaguePopup {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showCreateLeaguePopup = false // Dismiss popup when background is tapped
                        }
                    
                    VStack(spacing: 20) {
                        Text("Create New League")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        // Popup content with input fields
                        VStack(alignment: .leading, spacing: 15) {
                            Text("League Name:")
                                .font(.headline)
                            TextField("Enter league name", text: $leagueName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 10)
                            
                            Text("Points Start From Round:")
                                .font(.headline)
                            TextField("Enter round number", text: $pointsStartRound)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Buttons for confirming or canceling
                        HStack {
                            Button(action: {
                                showCreateLeaguePopup = false
                                leagues.append(leagueName) // Add the new league to the list
                                navigateToDetail = true // Navigate to the LeagueDetailPage
                            }) {
                                Text("Confirm")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            Button(action: {
                                showCreateLeaguePopup = false
                            }) {
                                Text("Cancel")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: 350)
                }
            }
            .background(Color(red: 0.9, green: 1.0, blue: 1.0))
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// Sample data
struct Members: Identifiable {
    var id = UUID()
    var rank: Int
    var name: String
    var points: Int
}

let teamsData = [
    Members(rank: 1, name: "fanwind", points: 49400),
    Members(rank: 2, name: "LieutenantTeez", points: 49100),
    Members(rank: 3, name: "Poethunder", points: 38440),
    Members(rank: 4, name: "theARABender", points: 34760),
    Members(rank: 5, name: "Minhaz", points: 30720),
    Members(rank: 6, name: "Talha FC", points: 23880)
]

struct FantasyPage_Previews: PreviewProvider {
    static var previews: some View {
        FantasyPage()
    }
}

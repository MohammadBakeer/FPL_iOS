import SwiftUI

struct JoinLeaguePage: View {
    @Binding var leagues: [String] // Binding to the leagues list
    @Binding var joinedLeague: String? // Binding to track the league the user joined
    @State private var navigateToLeagueView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Available Leagues")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.black)
            
            if leagues.isEmpty {
                Text("No leagues available to join at the moment.")
                    .font(.headline)
                    .padding(.top, 40)
            } else {
                // League List
                ForEach(leagues, id: \.self) { league in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "sportscourt")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 10)
                            
                            Text(league)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            if let currentLeague = joinedLeague, currentLeague == league {
                                Button(action: {
                                    navigateToLeagueView = true
                                }) {
                                    Text("View League")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                            } else if joinedLeague == nil {
                                Button(action: {
                                    joinLeague(league: league)
                                }) {
                                    Text("Join League")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                }
                            } else {
                                Text("Already in another league")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
            }
            
            Spacer()
            
            // Navigation Link to LeagueViewPage
            if let joinedLeague = joinedLeague {
                NavigationLink(destination: LeagueViewPage(leagueName: joinedLeague, leagueLogo: "sportscourt", leagues: $leagues), isActive: $navigateToLeagueView) {
                    EmptyView()
                }
            }
        }
        .background(Color(red: 0.9, green: 1.0, blue: 1.0))
        .ignoresSafeArea(edges: .bottom)
    }
    
    // Function to join a league
    private func joinLeague(league: String) {
        joinedLeague = league // Mark the league as joined
        navigateToLeagueView = true // Trigger navigation to LeagueViewPage
    }
}

struct JoinLeaguePage_Previews: PreviewProvider {
    @State static var previewLeagues = ["Hashir’s HQ", "Poethunder HQ"]
    @State static var previewJoinedLeague: String? = nil
    
    static var previews: some View {
        JoinLeaguePage(leagues: $previewLeagues, joinedLeague: $previewJoinedLeague)
    }
}

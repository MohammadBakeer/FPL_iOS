import SwiftUI

struct FantasyPage: View {
    @State private var showCreateLeaguePopup: Bool = false
    @State private var showJoinLeaguePopup: Bool = false
    @State private var leagueName: String = ""
    @State private var pointsStartRound: String = ""
    @State private var leagueCode: String = ""
    @State private var navigateToDetail: Bool = false
    @State private var leagues: [String] = ["Hashir’s HQ", "Poethunder HQ"] // Example leagues
    @State private var joinedLeague: String? = nil // Track the league the user joined
    @State private var globalPlayers: [Team] = teamsData // Global league data
    @State private var currentPage: Int = 1
    private let itemsPerPage = 5

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Fantasy Leagues")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .foregroundColor(.black)
                    
                    // Global League Section
                    VStack(spacing: 5) {
                        Text("Global League")
                            .font(.headline)
                            .padding(.vertical, 5)
                            .foregroundColor(.purple)
                        
                        // Table Header
                        HStack {
                            Text("Rank")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                            Text("Team")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                            Text("Squad")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                            Text("Points")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.purple)
                        
                        // Display rows based on current page
                        ForEach(currentPageItems(), id: \.id) { player in
                            HStack {
                                Text("\(player.rank)")
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity)
                                Text(player.name)
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity)
                                Button("View") {
                                    // Handle view squad action
                                }
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .font(.footnote)
                                Text("\(player.points)")
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.vertical, 2)
                        }
                        
                        // Pagination Controls
                        HStack {
                            Button(action: {
                                if currentPage > 1 {
                                    currentPage -= 1
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(currentPage > 1 ? .purple : .gray)
                            }
                            Text("\(currentPage) of \(totalPages())")
                                .font(.subheadline)
                                .padding(.horizontal, 8)
                            Button(action: {
                                if currentPage < totalPages() {
                                    currentPage += 1
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(currentPage < totalPages() ? .purple : .gray)
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    // Join and Create League Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            showCreateLeaguePopup = true
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
                                showJoinLeaguePopup = true
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
                    
                    // Private Leagues Section
                    if !leagues.isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Private Leagues")
                                .font(.headline)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            ForEach(leagues, id: \.self) { league in
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
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                }
                .background(Color(red: 0.9, green: 1.0, blue: 1.0))
                .ignoresSafeArea(edges: .bottom)
                
                // Popup for Creating a League
                if showCreateLeaguePopup {
                    popupView(
                        title: "Create New League",
                        content: {
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
                        },
                        onConfirm: {
                            if !leagueName.isEmpty {
                                leagues.append(leagueName)
                                leagueName = "" // Reset the input
                                pointsStartRound = "" // Reset the input
                                showCreateLeaguePopup = false
                            }
                        },
                        onCancel: {
                            showCreateLeaguePopup = false
                        }
                    )
                }
                
                // Popup for Joining a League
                if showJoinLeaguePopup {
                    popupView(
                        title: "Join League",
                        content: {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("League Code:")
                                    .font(.headline)
                                TextField("Enter league code", text: $leagueCode)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.bottom, 10)
                            }
                        },
                        onConfirm: {
                            if !leagueCode.isEmpty {
                                joinedLeague = "League joined with code: \(leagueCode)"
                                leagueCode = "" // Reset the input
                                showJoinLeaguePopup = false
                            }
                        },
                        onCancel: {
                            showJoinLeaguePopup = false
                        }
                    )
                }
            }
        }
    }
    
    private func popupView<Content: View>(
        title: String,
        @ViewBuilder content: @escaping () -> Content,
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) -> some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            content()
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            
            HStack {
                Button(action: onConfirm) {
                    Text("Confirm")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                Button(action: onCancel) {
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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 350)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func currentPageItems() -> [Team] {
        let startIndex = (currentPage - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, globalPlayers.count)
        return Array(globalPlayers[startIndex..<endIndex])
    }
    
    private func totalPages() -> Int {
        return (globalPlayers.count + itemsPerPage - 1) / itemsPerPage
    }
}

struct Team: Identifiable {
    var id = UUID()
    var rank: Int
    var name: String
    var points: Int
}

let teamsData = [
    Team(rank: 1, name: "fanwind", points: 49400),
    Team(rank: 2, name: "LieutenantTeez", points: 49100),
    Team(rank: 3, name: "Poethunder", points: 38440),
    Team(rank: 4, name: "theARABender", points: 34760),
    Team(rank: 5, name: "Minhaz", points: 30720),
    Team(rank: 6, name: "Talha FC", points: 23880),
    Team(rank: 7, name: "Maryam Bakeer", points: 133680),
    Team(rank: 8, name: "Mohammad JB", points: 107280)
]

struct FantasyPage_Previews: PreviewProvider {
    static var previews: some View {
        FantasyPage()
    }
}

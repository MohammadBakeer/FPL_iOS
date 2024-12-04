import SwiftUI

struct Home_Page: View {
    @StateObject private var teamViewModel = TeamViewModel() // Create an instance of TeamViewModel
    @AppStorage("user_id") private var userID: String = "" // Retrieve user_id from AppStorage
    
    var body: some View {
        NavigationView {
            VStack {
                // Title at the top
                Text("Poethunder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10) // Add extra space above the title
                              
                // ZStack for layering images (field and shirts)
                ZStack {
                    // Field Image from Assets folder
                    Image("new-field")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 390, height: 550)
                        .clipped()
                    
                    // Player positions
                    VStack(spacing: 40) {
                        // Forward players
                        HStack(spacing: 50) {
                            let fwdPlayers = teamViewModel.playerLineup.filter { $0.position == "FWD" }
                            if fwdPlayers.count >= 3 {
                                ForEach(fwdPlayers.prefix(3), id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            } else {
                                ForEach(0..<3 - fwdPlayers.count, id: \.self) { _ in
                                    PersonView(personName: "Player", shirtName: "default-shirt")
                                }
                                ForEach(fwdPlayers, id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            }
                        }
                        
                        // Midfield players
                        HStack(spacing: 40) {
                            let midPlayers = teamViewModel.playerLineup.filter { $0.position == "MID" }
                            if midPlayers.count >= 3 {
                                ForEach(midPlayers.prefix(3), id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            } else {
                                ForEach(0..<3 - midPlayers.count, id: \.self) { _ in
                                    PersonView(personName: "Player", shirtName: "default-shirt")
                                }
                                ForEach(midPlayers, id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            }
                        }
                        
                        // Defensive players
                        HStack(spacing: 10) {
                            let defPlayers = teamViewModel.playerLineup.filter { $0.position == "DEF" }
                            if defPlayers.count >= 4 {
                                ForEach(defPlayers.prefix(4), id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            } else {
                                ForEach(0..<4 - defPlayers.count, id: \.self) { _ in
                                    PersonView(personName: "Player", shirtName: "default-shirt")
                                }
                                ForEach(defPlayers, id: \.id) { player in
                                    PersonView(personName: player.name, shirtName: player.shirtName)
                                }
                            }
                        }
                        
                        // Goalkeeper
                        HStack {
                            if let goalkeeper = teamViewModel.playerLineup.first(where: { $0.position == "GK" }) {
                                PersonView(personName: goalkeeper.name, shirtName: goalkeeper.shirtName)
                                    .padding(.top, 20)
                            } else {
                                PersonView(personName: "Player", shirtName: "default-shirt")
                                    .padding(.top, 20)
                            }
                        }
                    }
                }
                
                Spacer()

                // Button to view the squad
                NavigationLink(destination: Edit_Team_Page()) {
                    Text("View Squad")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                // Fetch team using the userID from AppStorage
                teamViewModel.fetchTeam(userID: userID)
            }
        }
    }
}

struct PersonView: View {
    var personName: String
    var shirtName: String
 
    var body: some View {
        VStack {
            ZStack {
                // Background Rectangle
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green.opacity(0.7))
                    .frame(width: 84, height: 90)

                // Inner Rectangle for shirt image
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 83, height: 18) // Adjusted height for shirt view
                    .offset(y: 30)

                // Shirt Image
                Image(shirtName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .offset(y: -15)

                // Player Name
                Text(personName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 60)
            }
        }
    }
}

struct Home_Page_Previews: PreviewProvider {
    static var previews: some View {
        Home_Page()
            .previewDevice("iPhone 14 Pro")
    }
}

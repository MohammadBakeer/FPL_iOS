//
//  Edit_Team_Page.swift
//  iOS_Ultamite_FPL
//
//  Created by Mohammad Bakeer on 10/23/24.
//

import SwiftUI

struct Player {
    var name: String
    var shirtName: String
    var price: Double
}

struct TableView: View {
    let players: [(String, String, String, String)]
    var onPlayerSelected: (String, String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Name").frame(width: 80, alignment: .leading)
                Text("Club").frame(width: 80, alignment: .leading)
                Text("Position").frame(width: 80, alignment: .leading)
                Text("Price").frame(width: 80, alignment: .leading)
            }
            .font(.subheadline)
            .frame(height: 30)
            .padding(.horizontal, 5)
            .background(Color.gray.opacity(0.2))

            ForEach(players, id: \.0) { player in
                HStack {
                    Text(player.0).frame(width: 80, alignment: .leading)
                    Text(player.1).frame(width: 80, alignment: .leading)
                    Text(player.2).frame(width: 80, alignment: .leading)
                    Text(player.3).frame(width: 80, alignment: .leading)
                }
                .font(.footnote)
                .frame(height: 30)
                .padding(.horizontal, 5)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 1)
                .border(Color.gray.opacity(0.5))
                .onTapGesture {
                    // Call the closure with the player's club and position
                    onPlayerSelected(player.1, player.2)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}


struct Edit_Team_Page: View {
    
    let players = [
        ("Doe", "Arsenal", "FWD", "$5"),
        ("Smith", "Liverpool", "MID", "$2"),
        ("Johnson", "Chelsea", "DEF", "$8"),
        ("Davis", "Man City", "FWD", "$4"),
        ("Brown", "Tottenham", "MID", "$9"),
        ("Wilson", "Man Utd", "DEF", "$7"),
        ("Garcia", "Everton", "FWD", "$4"),
        ("Martinez", "Leicester", "MID", "$3"),
        ("Hernandez", "Aston Villa", "DEF", "$7"),
        ("Lopez", "Wolves", "FWD", "$7"),
        ("Taylor", "West Ham", "GK", "$3"),
        ("Anderson", "Southampton", "DEF", "$6")
    ]
    
    @State private var teamBudget = 85.0
    @State private var showRemovePopup = false
    @State private var selectedPlayer: (String, String, Double)?
    
    
    @State private var FWD: [Player] = [
        Player(name: "Player FWD 1", shirtName: "default-shirt", price: 0),
        Player(name: "Player FWD 2", shirtName: "default-shirt", price: 0),
        Player(name: "Player FWD 3", shirtName: "default-shirt", price: 0)
    ]
    
    @State private var MID: [Player] = [
        Player(name: "Player MID 1", shirtName: "default-shirt", price: 0),
        Player(name: "Player MID 2", shirtName: "default-shirt", price: 0),
        Player(name: "Player MID 3", shirtName: "default-shirt", price: 0)
    ]
    
    @State private var DEF: [Player] = [
        Player(name: "Player DEF 1", shirtName: "default-shirt", price: 0),
        Player(name: "Player DEF 2", shirtName: "default-shirt", price: 0),
        Player(name: "Player DEF 3", shirtName: "default-shirt", price: 0),
        Player(name: "Player DEF 4", shirtName: "default-shirt", price: 0)
    ]
    @State private var GK: Player = Player(name: "Player GK", shirtName: "default-shirt", price: 0)
    
    var body: some View {
        ScrollView {
            // Top of the VStack that contains everything
            VStack {
                // HStack for the Confirm button and changes text at the top
                HStack {
                    // Confirm button on the left
                    Button(action: {
                        // Add your confirm action here
                    }) {
                        Text("Confirm")
                            .font(.title3)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer() // Push the text to the right
                }
                .frame(maxWidth: .infinity, alignment: .leading)  // Ensures the HStack takes the full width, aligned to the leading edge
                
                .padding(.top, 10)  // Add some space to the top
                .padding(.horizontal, 20)  // Add padding to the sides
                
                Spacer()  // Add spacing from the top section
                Text("Team Budget: $\(teamBudget, specifier: "%.2f")")
                
                // Field and players
                ZStack {
                    Image("new-field")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 390, height: 550)
                        .clipped()
                    
                    VStack(spacing: 40) {
                        HStack(spacing: 50) {
                            ForEach(FWD.indices, id: \.self) { index in
                                PlayerView(playerName: FWD[index].name, shirtName: FWD[index].shirtName) {
                                    selectedPlayer = (FWD[index].name, "FWD", FWD[index].price)
                                    showRemovePopup = true
                                }
                            }
                        }
                        
                        HStack(spacing: 40) {
                            ForEach(MID.indices, id: \.self) { index in
                                PlayerView(playerName: MID[index].name, shirtName: MID[index].shirtName) {
                                    selectedPlayer = (MID[index].name, "MID", MID[index].price)
                                    showRemovePopup = true
                                }
                            }
                        }
                        
                        HStack(spacing: 13) {
                            ForEach(DEF.indices, id: \.self) { index in
                                PlayerView(playerName: DEF[index].name, shirtName: DEF[index].shirtName) {
                                    selectedPlayer = (DEF[index].name, "DEF", DEF[index].price)
                                    showRemovePopup = true
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            PlayerView(playerName: GK.name, shirtName: GK.shirtName) {
                                selectedPlayer = (GK.name, "GK", GK.price)
                                showRemovePopup = true
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                TableView(players: players) { selectedClub, selectedPosition in
                    let selectedPlayer = players.first(where: { $0.1 == selectedClub && $0.2 == selectedPosition })
                    let selectedPlayerPrice = selectedPlayer != nil ? Double(selectedPlayer!.3.dropFirst()) ?? 0.0 : 0.0
                    
                    switch selectedPosition {
                    case "FWD":
                        updatePlayerArray(&FWD, with: selectedClub, playerName: selectedPlayer!.0, playerPrice: selectedPlayerPrice)
                    case "MID":
                        updatePlayerArray(&MID, with: selectedClub, playerName: selectedPlayer!.0, playerPrice: selectedPlayerPrice)
                    case "DEF":
                        updatePlayerArray(&DEF, with: selectedClub, playerName: selectedPlayer!.0, playerPrice: selectedPlayerPrice)
                    case "GK":
                        GK.name = selectedClub
                        GK.shirtName = selectedClub
                    default:
                        return
                    }
                }
                Spacer()
            }
        }
      
        
        .alert(isPresented: $showRemovePopup) {
            Alert(
                title: Text("Remove Player"),
                message: Text("Are you sure you want to remove \(selectedPlayer?.0 ?? "") from your team?"),
                primaryButton: .destructive(Text("Remove")) {
                    removePlayer()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func removePlayer() {
        guard let player = selectedPlayer else { return }

        let position = player.1
        let price = player.2

        switch position {
        case "FWD":
            if let index = FWD.firstIndex(where: { $0.name == player.0 }) {
                FWD[index].shirtName = "default-shirt"
                FWD[index].price = 0
            }
        case "MID":
            if let index = MID.firstIndex(where: { $0.name == player.0 }) {
                MID[index].shirtName = "default-shirt"
                MID[index].price = 0
            }
        case "DEF":
            if let index = DEF.firstIndex(where: { $0.name == player.0 }) {
                DEF[index].shirtName = "default-shirt"
                DEF[index].price = 0
            }
        case "GK":
            GK = Player(name: "Player GK", shirtName: "default-shirt", price: 0)
        default:
            return
        }
        
        teamBudget += price
            }
                    
                private func updatePlayerArray(_ players: inout [Player], with club: String, playerName: String, playerPrice: Double) {
                        if let index = players.firstIndex(where: { $0.shirtName == "default-shirt" }) {
                            players[index].name = playerName // Update the player's name
                            players[index].shirtName = club // Use the club name for the shirt name
                            players[index].price = playerPrice // Set the player's price
                            
                            // Deduct the player's price from the budget
                            teamBudget -= playerPrice
                        }
                    }
                }




struct PlayerView: View {
    var playerName: String
    var shirtName: String
    var onTap: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green.opacity(0.7))
                    .frame(width: 84, height: 90)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 70, height: 90 * 0.2)
                    .offset(y: 10)
                
                Image(shirtName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .offset(y: -15)
                
                Text(playerName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 60)
            }
            .onTapGesture {
                onTap()
            }
        }
    }
    
    
    struct Edit_Team_Page_Previews: PreviewProvider {
        static var previews: some View {
            Edit_Team_Page()
        }
    }
}

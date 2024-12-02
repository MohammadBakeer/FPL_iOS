//
//  Edit_Team_Page.swift
//  iOS_Ultimate_FPL
//
//  Created by Hashirul Quadir on 10/24/24.
//

import SwiftUI

// Define the Player struct
struct Player: Identifiable {
    var id = UUID()
    var name: String
    var shirtName: String
    var price: Double
}

// Define the PlayerView component
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
                    .frame(width: 70, height: 18) // Adjusted height for shirt view
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
}

// Define the TableView component
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
                    onPlayerSelected(player.1, player.2)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}

struct Edit_Team_Page: View {
    @Environment(\.presentationMode) var presentationMode

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
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0)
    ]
    @State private var MID: [Player] = [
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0)
    ]
    @State private var DEF: [Player] = [
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0),
        Player(name: "Player", shirtName: "default-shirt", price: 0)
    ]
    @State private var GK: Player = Player(name: "Player", shirtName: "default-shirt", price: 0)

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        // Save Changes and go back to Home_Page
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save Changes")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)

                Text("Team Budget: $\(teamBudget, specifier: "%.2f")")
                    .font(.headline)
                    .padding(.vertical, 10)

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
        .navigationBarBackButtonHidden(true) // Hide the back button
    }

    func removePlayer() {
        guard let player = selectedPlayer else { return }

        let position = player.1
        let price = player.2

        switch position {
        case "FWD":
            if let index = FWD.firstIndex(where: { $0.name == player.0 }) {
                FWD[index].name = "Player"
                FWD[index].shirtName = "default-shirt"
                FWD[index].price = 0
            }
        case "MID":
            if let index = MID.firstIndex(where: { $0.name == player.0 }) {
                MID[index].name = "Player"
                MID[index].shirtName = "default-shirt"
                MID[index].price = 0
            }
        case "DEF":
            if let index = DEF.firstIndex(where: { $0.name == player.0 }) {
                DEF[index].name = "Player"
                DEF[index].shirtName = "default-shirt"
                DEF[index].price = 0
            }
        case "GK":
            GK = Player(name: "Player", shirtName: "default-shirt", price: 0)
        default:
            return
        }

        teamBudget += price
    }

    private func updatePlayerArray(_ players: inout [Player], with club: String, playerName: String, playerPrice: Double) {
        if let index = players.firstIndex(where: { $0.shirtName == "default-shirt" }) {
            players[index].name = playerName
            players[index].shirtName = club
            players[index].price = playerPrice
            teamBudget -= playerPrice
        }
    }
}

struct Edit_Team_Page_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Team_Page()
    }
}

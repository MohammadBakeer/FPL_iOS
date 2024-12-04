import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var team: Team?
    @Published var playerLineup: [Player] = []
    @Published var formation: [String] = []
    @Published var totalBudget: Double = 0.0
    @Published var points: Int = 0
    @Published var deleteCount: Int = 0
    @Published var changeCount: Int = 0

    func fetchTeam(userID: String) {
        guard let url = URL(string: "http://localhost:3000/auth/fetchTeam") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["user_id": userID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching team: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Print the raw response data to check if the API call works
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            do {
                var team = try JSONDecoder().decode(Team.self, from: data)
                
                // Handle missing or empty player data
                for i in 0..<team.playerLineup.count {
                    if team.playerLineup[i].name.isEmpty {
                        team.playerLineup[i].name = "Player"
                    }
                    if team.playerLineup[i].shirtName.isEmpty {
                        team.playerLineup[i].shirtName = "default-shirt"
                    }
                    if team.playerLineup[i].price == 0.00 {
                        team.playerLineup[i].price = 0.00
                    }
                    if team.playerLineup[i].position.isEmpty {
                        team.playerLineup[i].position = "Unknown"
                    }
                }
                
                DispatchQueue.main.async {
                    self.team = team
                    self.playerLineup = team.playerLineup
                    self.formation = team.formation
                    self.totalBudget = team.totalBudget
                    self.points = team.points
                    self.deleteCount = team.deleteCount
                    self.changeCount = team.changeCount
                }
            } catch {
                print("Error decoding team: \(error.localizedDescription)")
            }
        }.resume()
    }
}

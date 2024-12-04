import SwiftUI

struct LeagueViewPage: View {
    var leagueName: String
    var leagueLogo: String // Placeholder for logo
    @Binding var leagues: [String] // Binding to the leagues list
    @Environment(\.presentationMode) var presentationMode
    
    let teamsData = [
        Members(rank: 1, name: "fanwind", points: 49400),
        Members(rank: 2, name: "LieutenantTeez", points: 49100),
        Members(rank: 3, name: "Poethunder", points: 38440),
        Members(rank: 4, name: "theARABender", points: 34760)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with League Name and Logo
            HStack {
                Text(leagueName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(leagueLogo)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
            }
            .padding(.horizontal)
            
            // Table Section (Team Rankings)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Rank")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Team Name")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Points")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                
                ForEach(teamsData, id: \.rank) { team in
                    HStack {
                        Text("\(team.rank)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(team.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(team.points)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(Color.white)
                    .border(Color.gray.opacity(0.5))
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Leave League Button
            Button(action: {
                // Remove the league and navigate back
                if let index = leagues.firstIndex(of: leagueName) {
                    leagues.remove(at: index)
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Leave League")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color(red: 0.9, green: 1.0, blue: 1.0))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct LeagueViewPage_Previews: PreviewProvider {
    @State static var previewLeagues = ["Hashir’s HQ"]
    
    static var previews: some View {
        LeagueViewPage(leagueName: "Hashir’s HQ", leagueLogo: "sportscourt", leagues: $previewLeagues)
    }
}

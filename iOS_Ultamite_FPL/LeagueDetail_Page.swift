import SwiftUI

struct LeagueDetailPage: View {
    var leagueName: String
    @Binding var leagues: [String] // Binding to the leagues list
    @State private var navigateToLeagueView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Fantasy Leagues")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.black)
            
            // League Card Section
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "sportscourt")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    
                    Text(leagueName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToLeagueView = true
                    }) {
                        Text("View League")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.vertical, 20)
            
            Spacer()
            
            // Navigation Link to LeagueViewPage
            NavigationLink(
                destination: LeagueViewPage(leagueName: leagueName, leagueLogo: "sportscourt", leagues: $leagues),
                isActive: $navigateToLeagueView
            ) {
                EmptyView()
            }
        }
        .background(Color(red: 0.9, green: 1.0, blue: 1.0))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct LeagueDetailPage_Previews: PreviewProvider {
    @State static var previewLeagues = ["Hashir’s HQ", "Poethunder HQ"]
    
    static var previews: some View {
        LeagueDetailPage(leagueName: "Hashir’s HQ", leagues: $previewLeagues)
    }
}

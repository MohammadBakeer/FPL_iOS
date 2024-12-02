import Foundation

class RoundManager {
    static let shared = RoundManager()
    private var roundUpdateTimer: Timer?

    // Make roundNum non-optional, with a default value (-1 for error/fallback)
    var roundNum: Int = -1

    private init() {
        // Fetch the initial round number synchronously when the app launches
        fetchRoundNum { round in
            // Handle the fetched round (this will run only once at launch)
            print("Fetched initial round number: \(round ?? -1)")
        }
        startRoundNumberUpdateTimer()  // Start the periodic update every 12 hours
    }

    func fetchRoundNum(completion: @escaping (Int?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/auth/fetchRound") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching round: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let roundNum = json?["round_num"] as? Int {
                        self.roundNum = roundNum  // Update the stored round number
                        completion(roundNum)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error parsing response: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }.resume()
    }

    private func startRoundNumberUpdateTimer() {
        // 12 hours = 43200 seconds
        roundUpdateTimer = Timer.scheduledTimer(withTimeInterval: 43200, repeats: true) { _ in
            self.fetchRoundNum { round in
                print("Fetched new round number: \(round ?? -1)")
            }
        }
    }
}

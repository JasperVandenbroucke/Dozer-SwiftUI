import Foundation

struct NetworkManager {
    
    static let baseURL: URL = {
        guard let url = URL(string: "https://api.openweathermap.org") else {
            fatalError("Error: invalid URL")
        }
        return url
    }()

}

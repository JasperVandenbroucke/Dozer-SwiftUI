import Foundation

class NetworkManager {
    
    // API url setup
    static let baseURL: URL = {
        guard let url = URL(string: "http://localhost:3000") else {
            fatalError("Error: invalid URL")
        }
        return url
    }()
    
    // GET MACHINES
    func fetchMachines(completionHandler: @escaping ([Machine]) -> Void) {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines")
        
        // Create an asynchronous task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, res, err) in
            // First check for any errors
            if let error = err {
                print("Error: couldn't fetch machines: \(error)")
                return
            }
            
            // Second check the status
            guard let httpResponse = res as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: unexpected status code")
                return
            }
            
            // No problems? Go on!
            if let data = data,
               let machines = try? JSONDecoder().decode([Machine].self, from: data) {
                completionHandler(machines)
            }
        })
        // Start the asynchronous task
        task.resume()
    }

}

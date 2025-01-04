import Foundation

// @escaping: use/execute a closure later in the function

class NetworkManager : MachinesNetworkProtocol {
    
    // MARK: - API url setup
    static let baseURL: URL = {
        guard let url = URL(string: "http://localhost:3000") else {
            fatalError("Error: invalid URL")
        }
        return url
    }()
    
    // MARK: - GET MACHINES
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
                let statusCode = (res as? HTTPURLResponse)?.statusCode ?? -1
                print("Error: unexpected status code: \(statusCode)")
                return
            }
            
            print(url)
            
            // No problems? Go on!
            if let data = data,
               let machines = try? JSONDecoder().decode([Machine].self, from: data) {
                completionHandler(machines)
            }
        })
        // Start the asynchronous task
        task.resume()
    }

    // MARK: - CREATE MACHINE
    func createMachine(machine: Machine, completionHandler: @escaping (Machine) -> Void) {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines")
        
        // Parse machine to JSON
        guard let jsonData = try? JSONEncoder().encode(machine) else {
            print("Error: couldn't parse the machine to JSON")
            return
        }
        
        // Create the POST request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Create an asynchronous task
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            //First check for any errors
            if let error = err {
                print("Error: couldn't create machine: \(error)")
                return
            }
            
            // Second check the status
            guard let httpResponse = res as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (res as? HTTPURLResponse)?.statusCode ?? -1
                print("Error: unexpected status code: \(statusCode)")
                return
            }
            
            // No problems? Go on!
            if let data = data,
               let newMachine = try? JSONDecoder().decode(Machine.self, from: data) {
                completionHandler(newMachine)
            }
        }
        // Start the asynchronous task
        task.resume()
    }
    
    // MARK: - UPDATE MACHINE BY ID
    func updateMachineById(machine: Machine, completionHandler: @escaping (Machine) -> Void) {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines/\(machine.id!)")
        
        // Parse the updated machine to JSON
        guard let jsonData = try? JSONEncoder().encode(machine) else {
            print("Error: couldn't parse the machine to JSON")
            return
        }
        
        // Create the PUT request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Create an asynchronous task
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            // First check for any errors
            if let error = err {
                print("Error: couldn't update machine: \(error)")
                return
            }
            
            // Second check the status
            guard let httpResponse = res as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (res as? HTTPURLResponse)?.statusCode ?? -1
                print("Error: unexpected status code: \(statusCode)")
                return
            }
            
            // No problems? Go on!
            if let data = data,
               let updatedMachine = try? JSONDecoder().decode(Machine.self, from: data) {
                completionHandler(updatedMachine)
            }
        }
        // Start the asynchronous task
        task.resume()
    }
    
    // MARK: - DELETE MACHINE BY ID
    func deleteMachineById(id: IndexSet, completionHandler: @escaping (Machine) -> Void) {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines/\(id)");
        
        // Create the DELETE request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // Create an asynchronous task
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            //First check for any errors
            if let error = err {
                print("Error: couldn't delete machine: \(error)")
            }
            
            // Second check the status
            guard let httpResponse = res as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (res as? HTTPURLResponse)?.statusCode ?? -1
                print("Error: unexpected status code: \(statusCode)")
                return
            }
            
            // No problems? Go on!
            if let data = data,
               let deletedMachine = try? JSONDecoder().decode(Machine.self, from: data) {
                completionHandler(deletedMachine)
            }
        }
        // Start the asynchronous task
        task.resume()
    }
}

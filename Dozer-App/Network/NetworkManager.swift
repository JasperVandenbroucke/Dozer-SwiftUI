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
    func fetchMachines() async throws -> [Machine] {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw DozerError.invalidResponse
        }
        
        try checkStatusCode(response.statusCode)
        
        do {
            return try JSONDecoder().decode([Machine].self, from: data)
        } catch {
            throw DozerError.invalidData
        }
    }

    // MARK: - CREATE MACHINE
    func createMachine(machine: Machine) async throws -> Machine {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines")
        
        guard let jsonData = try? JSONEncoder().encode(machine) else {
            throw DozerError.invalidMachine
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw DozerError.invalidResponse
        }
        
        try checkStatusCode(response.statusCode)
        
        do {
            return try JSONDecoder().decode(Machine.self, from: data)
        } catch {
            throw DozerError.invalidData
        }
    }
    
    // MARK: - UPDATE MACHINE BY ID
    func updateMachine(machine: Machine) async throws -> Machine {
        guard let machineId = machine.id else {
            throw DozerError.invalidMachineId
        }
        
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines/\(machineId)")
        
        guard let jsonData = try? JSONEncoder().encode(machine) else {
            throw DozerError.invalidMachine
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw DozerError.invalidResponse
        }
        
        try checkStatusCode(response.statusCode)
        
        do {
            return try JSONDecoder().decode(Machine.self, from: data)
        } catch {
            throw DozerError.invalidData
        }
    }
    
    // MARK: - DELETE MACHINE BY ID
    func deleteMachineById(id: Int) async throws -> Machine {
        let url = NetworkManager.baseURL.appendingPathComponent("/api/machines/\(id)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw DozerError.invalidResponse
        }
        
        try checkStatusCode(response.statusCode)
        
        do {
            return try JSONDecoder().decode(Machine.self, from: data)
        } catch {
            throw DozerError.invalidData
        }
    }
    
    func checkStatusCode(_ statusCode: Int) throws {
        switch statusCode {
        case 200...299: break
        case 400: throw DozerError.badRequest
        case 404: throw DozerError.notFound
        case 500: throw DozerError.internalServerError
        default: throw DozerError.unknownStatusCode(statusCode)
        }
    }
}

enum DozerError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case badRequest
    case notFound
    case internalServerError
    case unknownStatusCode(Int)
    case invalidMachineId
    case invalidMachine
}

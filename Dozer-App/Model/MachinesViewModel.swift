import SwiftUI

@MainActor
class MachinesViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    @Published var machinesList: [Machine] = []
    @Published var currentMachine: Machine
    
    @Published var successUpdate: Bool = false
    @Published var successCreate: Bool = false
    
    @Published var errorUpdate: Bool = false
    @Published var errorCreate: Bool = false
    @Published var errorMessage: String = ""
    
    private let machineService: MachinesNetworkProtocol
    
    // MARK: INIT
    init(machinesService: MachinesNetworkProtocol = NetworkManager()) {
        self.machineService = machinesService
        self.currentMachine = Machine(id: 0, machineName: "", machineType: "", basePrice: 0, options: [])
    }
    
    // MARK: FUNCTIONS
    // Get the machines
    func fetchMachines() async {
        do {
            machinesList = try await machineService.fetchMachines()
        } catch DozerError.invalidResponse {
            print("invalid response")
        } catch DozerError.badRequest {
            print("Bad request")
        } catch DozerError.notFound {
            print("Not found")
        } catch DozerError.internalServerError {
            print("Internal server error")
        } catch DozerError.unknownStatusCode(let statusCode) {
            print("Unknown status code: \(statusCode)")
        } catch DozerError.invalidData {
            print("invalid data")
        } catch {
            print("unexpected error")
        }
    }
    
    // Create a new machine
    func createMachine(machineName: String, machineType: String, machinePrice: Double, options: [Option]) async {
        do {
            let machine = Machine(machineName: machineName, machineType: machineType, basePrice: machinePrice, options: options)
            let newMachine = try await machineService.createMachine(machine: machine)
            machinesList.append(newMachine)
            self.successCreate = true
            print(newMachine)
        } catch DozerError.invalidMachine {
            showCreateError(message: "Invalid machine")
        } catch DozerError.invalidResponse {
            showCreateError(message: "Invalid response")
        } catch DozerError.badRequest {
            showCreateError(message: "Your changes are... questionable. Please try again")
        } catch DozerError.notFound {
            showCreateError(message: "Nothing found")
        } catch DozerError.internalServerError {
            showCreateError(message: "Server failed")
        } catch DozerError.unknownStatusCode(let statusCode) {
            showCreateError(message: "What happend? \(statusCode)")
        } catch DozerError.invalidData {
            showCreateError(message: "Invalid data")
        } catch {
            showCreateError(message: "Unexpected error")
        }
    }
    
    // Update a machine
    func updateMachine(machine: Machine) async {
        do {
            let updatedMachine = try await machineService.updateMachine(machine: machine)
            if let index = machinesList.firstIndex(where: { $0.id == updatedMachine.id }) {
                machinesList[index] = updatedMachine
            }
            self.successUpdate = true
            print(updatedMachine)
        } catch DozerError.invalidMachineId {
            showUpdateError(message: "Invalid machine ID")
        } catch DozerError.invalidMachine {
            showUpdateError(message: "Invalid machine")
        } catch DozerError.invalidResponse {
            showUpdateError(message: "Invalid response")
        } catch DozerError.badRequest {
            showUpdateError(message: "Your changes are... questionable. Please try again")
        } catch DozerError.notFound {
            showUpdateError(message: "Nothing found")
        } catch DozerError.internalServerError {
            showUpdateError(message: "Server failed")
        } catch DozerError.unknownStatusCode(let statusCode) {
            showUpdateError(message: "What happend? \(statusCode)")
        } catch DozerError.invalidData {
            showUpdateError(message: "Invalid data")
        } catch {
            showUpdateError(message: "Unexpected error")
        }
    }
    
    // Delete a machine
    func deleteMachine(id: Int) async {
        do {
            let deletedMachine = try await machineService.deleteMachineById(id: id)
            if let index = machinesList.firstIndex(where: { $0.id == deletedMachine.id }) {
                machinesList.remove(at: index)
            }
            print(deletedMachine)
        } catch DozerError.invalidResponse {
            print("invalid response")
        } catch DozerError.badRequest {
            print("Bad request")
        } catch DozerError.notFound {
            print("Not found")
        } catch DozerError.internalServerError {
            print("Internal server error")
        } catch DozerError.unknownStatusCode(let statusCode) {
            print("Unknown status code: \(statusCode)")
        } catch DozerError.invalidData {
            print("invalid data")
        } catch {
            print("unexpected error")
        }
    }
    
    private func showUpdateError(message: String) {
        self.errorUpdate = true
        self.errorMessage = message
    }
    
    private func showCreateError(message: String) {
        self.errorCreate = true
        self.errorMessage = message
    }
}

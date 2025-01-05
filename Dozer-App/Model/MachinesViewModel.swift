import SwiftUI

@MainActor
class MachinesViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    @Published var machinesList: [Machine] = []
    @Published var currentMachine: Machine
    
    @Published var successUpdate: Bool = false
    
    @Published var errorUpdate: Bool = false
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
            print(newMachine)
        } catch DozerError.invalidMachine {
            print("invalid machine")
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
            print("Invalid data")
        } catch {
            print("unexpected error")
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
            showError(message: "Invalid machine ID")
        } catch DozerError.invalidMachine {
            showError(message: "Invalid machine")
        } catch DozerError.invalidResponse {
            showError(message: "Invalid response")
        } catch DozerError.badRequest {
            showError(message: "Your changes are... questionable. Please try again")
        } catch DozerError.notFound {
            showError(message: "Nothing found")
        } catch DozerError.internalServerError {
            showError(message: "Server failed")
        } catch DozerError.unknownStatusCode(let statusCode) {
            showError(message: "What happend? \(statusCode)")
        } catch DozerError.invalidData {
            showError(message: "Invalid data")
        } catch {
            showError(message: "Unexpected error")
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
    
    private func showError(message: String) {
        self.errorUpdate = true
        self.errorMessage = message
    }
}

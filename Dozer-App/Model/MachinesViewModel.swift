import SwiftUI

class MachinesViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    @Published var machinesList: [Machine] = []
    @Published var currentMachine: Machine
    
    private let machineService: MachinesNetworkProtocol
    var successUpdate: Bool = false
    
    // MARK: INIT
    init(machinesService: MachinesNetworkProtocol = NetworkManager()) {
        self.machineService = machinesService
        self.currentMachine = Machine(id: 0, machineName: "", machineType: "", basePrice: 0, options: [])
        fetchMachines()
    }
    
    // MARK: FUNCTIONS
    // Get the machines
    func fetchMachines(searchText: String? = nil) {
        machineService.fetchMachines { (machines) in
            print(machines)
            DispatchQueue.main.async {
                self.machinesList = machines
            }
        }
    }
    
    // Create a new machine
    func createMachine(machine: Machine) {
        machineService.createMachine(machine: machine) { (machine) in
            print(machine)
        }
    }
    
    // Update a machine
    func updateMachine(machine: Machine) {
        machineService.updateMachineById(machine: machine) { (updatedMachine) in
            print(updatedMachine)
            DispatchQueue.main.async {
                self.machinesList = self.machinesList.map { $0.id == updatedMachine.id ? updatedMachine : $0 }
                self.successUpdate = true
            }
        }
    }
    
    // Delete a machine
    func deleteMachine(id: Int) {
        machineService.deleteMachineById(id: id) { (removedMachine) in
            print(removedMachine)
            DispatchQueue.main.async {
                self.machinesList.removeAll { $0.id == removedMachine.id }
            }
        }
    }
}

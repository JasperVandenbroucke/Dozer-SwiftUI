import SwiftUI

class MachinesViewModel: ObservableObject {
    
    @Published var machinesList: [Machine] = []
    @Published var currentMachine: Machine?
    
    var searchText: String = ""
    
    private let machineService: MachinesNetworkProtocol
    
    init(machinesService: MachinesNetworkProtocol = NetworkManager()) {
        self.machineService = machinesService
        fetchMachines()
    }
    
    // Get the machines
    func fetchMachines() {
        machineService.fetchMachines { (machines) in
            print(machines)
            DispatchQueue.main.async {
                self.machinesList = machines
            }
        }
    }
    
    // Get a machine by id
    func fetchMachineById(id: Int) {
        machineService.fetchMachineById(id: id) { (machine) in
            print(machine)
            DispatchQueue.main.async {
                self.currentMachine = machine
            }
        }
    }
    
    // Get machines by type
    func fetchMachinesByType(type: String) {
        machineService.fetchMachinesByType(type: type) { (machines) in
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
        machineService.updateMachineById(machine: machine) { (machine) in
            print(machine)
        }
    }
    
    // Delete a machine
    func deleteMachine(id: Int) {
        machineService.deleteMachineById(id: id) { (machine) in
            print(machine)
        }
    }
}

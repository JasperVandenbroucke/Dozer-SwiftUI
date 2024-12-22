import SwiftUI

class MachinesViewModel: ObservableObject {
    
    @Published var machinesList: [Machine] = []
    @Published var currentMachine: Machine?
    
    // Get the machines
    func fetchMachines() {
        NetworkManager().fetchMachines { (machines) in
            print(machines)
            DispatchQueue.main.async {
                self.machinesList = machines
            }
        }
    }
    
    // Get a machine by id
    func fetchMachineById(id: Int) {
        NetworkManager().fetchMachineById(id: id) { (machine) in
            print(machine)
            DispatchQueue.main.async {
                self.currentMachine = machine
            }
        }
    }
    
    // Get machines by type
    func fetchMachinesByType(type: String) {
        NetworkManager().fetchMachinesByType(type: type) { (machines) in
            print(machines)
            DispatchQueue.main.async {
                self.machinesList = machines
            }
        }
    }
    
    // Create a new machine
    func createMachine(machine: Machine) {
        NetworkManager().createMachine(machine: machine) { (machine) in
            print(machine)
        }
    }
    
}

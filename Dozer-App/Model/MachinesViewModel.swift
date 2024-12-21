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
    
}

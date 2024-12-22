import SwiftUI

struct HomeScreen: View {
    
    // Create a viewModel instance here
    @StateObject var machinesViewModel = MachinesViewModel()
    
    var body: some View {
        Text("Let's test my API calls!")
        Button("Get Machines") {
            machinesViewModel.fetchMachines()
        }
        if !machinesViewModel.machinesList.isEmpty {
            Text("Successfully fetched the machines! Great job!")
        }
        Button("Get a machine") {
            machinesViewModel.fetchMachineById(id: 1)
        }
        if machinesViewModel.currentMachine != nil {
            Text("Successfully fetched the machine! Great job!")
        }
        Button("Create a machine") {
            machinesViewModel.createMachine(machine: Machine(machineName: "My new machine", machineType: "Bulldozer", basePrice: 234000, options: []))
        }
    }
}

#Preview {
    HomeScreen()
}

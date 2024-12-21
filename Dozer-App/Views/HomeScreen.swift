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
    }
}

#Preview {
    HomeScreen()
}

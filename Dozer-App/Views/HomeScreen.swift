import SwiftUI

struct HomeScreen: View {
    
    // Injecting the MachinesViewModel
    @EnvironmentObject var machinesViewModel: MachinesViewModel

    var body: some View {
        VStack() {
            // Search
            
            // Machines
            NavigationStack {
                List(machinesViewModel.machinesList) { machine in
                    MachineListItem(machine: machine)
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(MachinesViewModel())
}

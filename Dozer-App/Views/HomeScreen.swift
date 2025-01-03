import SwiftUI

struct HomeScreen: View {
    
    // Injecting the MachinesViewModel
    @EnvironmentObject var machinesViewModel: MachinesViewModel

    var body: some View {
        VStack() {
            // Machines
            NavigationStack {
                MachinesList(
                    machinesList: machinesViewModel.machinesList
                )
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(MachinesViewModel())
}

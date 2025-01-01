import SwiftUI

struct HomeScreen: View {
    
    // Injecting the MachinesViewModel
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    @State var searchText: String = ""

    var body: some View {
        VStack() {
            // Machines
            NavigationStack {
                List($machinesViewModel.machinesList) { machine in
                    MachineListItem(machine: machine)
                }
            }
            .searchable(text: $searchText, prompt: "Search for name or type")
            .onSubmit(of: .search) {
                machinesViewModel.fetchMachines(searchText: searchText)
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(MachinesViewModel())
}

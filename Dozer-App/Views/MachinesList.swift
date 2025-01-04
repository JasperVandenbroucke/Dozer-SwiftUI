import SwiftUI

struct MachinesList: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    var machinesList: [Machine]
    
    var body: some View {
        List {
            ForEach(machinesList) { machine in
                NavigationLink(destination: MachineDetailsView(machine: $machinesViewModel.currentMachine)) {
                    MachineListItem(machine: machine)
                }
                .onTapGesture {
                    machinesViewModel.currentMachine = machine
                }
            }
            .onDelete(perform: { indexSet in
                    delete(indexSet)
            })
        }
    }
    
    func delete(_ indexSet: IndexSet) {
        machinesViewModel.deleteMachine(id: indexSet)
    }
}

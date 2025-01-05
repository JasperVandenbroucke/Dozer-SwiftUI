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
        .toolbar {
            addMachineButton
        }
    }
    
    var addMachineButton: some View {
        NavigationStack {
            NavigationLink(destination: AddMachineView()) {
                Text("Add Machine")
            }
        }
    }
    
    func delete(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let machineToDelete = machinesList[index]
            machinesViewModel.deleteMachine(id: machineToDelete.id!)
        }
    }
}

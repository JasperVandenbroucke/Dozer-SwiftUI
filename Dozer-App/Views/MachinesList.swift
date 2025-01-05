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
                Task {
                    await delete(indexSet)
                }
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
    
    func delete(_ indexSet: IndexSet) async {
        for index in indexSet {
            print(index)
            let machineToDelete = machinesList[index]
            print(machineToDelete)
            await machinesViewModel.deleteMachine(id: machineToDelete.id!)
        }
    }
}

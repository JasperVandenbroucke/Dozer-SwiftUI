import SwiftUI

struct AddMachineView: View {
    
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    @State var machineName: String = ""
    @State var machineType: String = ""
    @State var machinePrice: Double = 0.0
    
    @State var optionName: String = ""
    @State var optionPrice: Double = 0.0
    
    @State private var options: [Option] = []
    
    var body: some View {
        Form {
            machineInfo
            machineOptions
            Button("Add Machine") {
                Task {
                    await addMachine()
                }
            }
        }
    }
    
    var machineInfo: some View {
        Section(header: Text("Machine Info")) {
            TextField("Machine Name", text: $machineName)
            TextField("Machine Type", text: $machineType)
            TextField("Price", value: $machinePrice, format: .number)
        }
    }
    
    @ViewBuilder
    var machineOptions: some View {
        Section(header: Text("Machine Options")) {
            TextField("Option Name", text: $optionName)
            TextField("Option Price", value: $optionPrice, format: .number)
            Button("Add Option") {
                addOption()
            }
        }
        Section {
            Text("Amount of options: \(options.count)")
            ForEach(options) { option in
                Text(option.optionName)
            }
        }
    }
    
    func addOption() {
        if !optionName.isEmpty && !optionPrice.isNaN && optionPrice > 0 {
            options.append(Option(optionName: optionName, price: optionPrice))
            optionName = ""
            optionPrice = 0.0
        }
    }
    
    func addMachine() async {
        // TODO: IMPLEMENT AN ADD MACHINE (PASSING VALUES NO MACHINE)
        await machinesViewModel.createMachine(
            machineName: machineName,
            machineType: machineType,
            machinePrice: machinePrice,
            options: options
        )
    }
}

#Preview {
    AddMachineView()
}

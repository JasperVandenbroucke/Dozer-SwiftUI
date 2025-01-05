import SwiftUI

struct AddMachineView: View {
    
    @State var machineName: String = ""
    @State var machineType: String = ""
    @State var machinePrice: Double = 0.0
    
    @State var optionName: String = ""
    @State var optionPrice: Double = 0.0
    
    @State private var options: [Option] = []
    
    var body: some View {
        Form {
            Section(header: Text("Machine Info")) {
                TextField("Machine Name", text: $machineName)
                TextField("Machine Type", text: $machineType)
                //TextField("Price", text: $machinePrice)
            }
            Section(header: Text("Machine Options")) {
                TextField("Option Name", text: $optionName)
                //TextField("Option Price", text: $optionPrice)
                Button("Add Option") {
                    addOption()
                }
            }
            Section {
                Text("Amount of options: \(options.count)")
            }
            Button("Add Machine") {
                addMachine()
            }
        }
    }
    
    func addOption() {
        if !optionName.isEmpty && !optionPrice.isNaN {
            options.append(Option(optionName: optionName, price: optionPrice))
            optionName = ""
            optionPrice = 0.0
        }
    }
    
    func addMachine() {
        // TODO: IMPLEMENT AN ADD MACHINE (PASSING VALUES NO MACHINE)
    }
}

#Preview {
    AddMachineView()
}

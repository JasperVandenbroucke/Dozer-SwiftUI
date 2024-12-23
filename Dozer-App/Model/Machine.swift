import Foundation

struct Machine: Identifiable, Codable {
    var id: Int?
    var machineName: String
    var machineType: String
    var basePrice: Double
    var options: [Option]
}

struct Option: Codable {
    var optionName: String
    var price: Double
}

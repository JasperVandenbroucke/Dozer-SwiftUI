import Foundation

struct Machine: Codable {
    var id: Int
    var machineName: String
    var machineType: String
    var basePrice: Double
    var options: [Option]
}

struct Option: Codable {
    var id: Int
    var optionName: String
    var price: Double
}
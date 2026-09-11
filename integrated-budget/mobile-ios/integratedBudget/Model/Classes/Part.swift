import Foundation

class Part {
    var id: String
    var name: String
    var brand: String
    var model: String
    var year: Int
    var price: Double
    var vendorId: String
    var vendorName: String
    
    init(id: String, name: String, brand: String, model: String, year: Int, price: Double, vendorId: String, vendorName: String) {
        self.id = id
        self.name = name
        self.brand = brand
        self.model = model
        self.year = year
        self.price = price
        self.vendorId = vendorId
        self.vendorName = vendorName
    }
}

class PartWithAmount: Part {
    var amount: Int
    
    init(id: String, name: String, brand: String, model: String, year: Int, price: Double, amount: Int, vendorId: String, vendorName: String) {
        self.amount = amount
        super.init(id: id, name: name, brand: brand, model: model, year: year, price: price, vendorId: vendorId, vendorName: vendorName)
    }
}

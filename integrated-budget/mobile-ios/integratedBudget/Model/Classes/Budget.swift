import Foundation

class Budget {
    var id: String
    var status: String
    var name: String
    var brand: String
    var model: String
    var year: Int
    var mechanicId: String
    var parts: [PartWithAmount] = []
    
    init(id: String, status: String, name: String, brand: String, model: String, year: Int, mechanicId: String) {
        self.id = id
        self.status = status
        self.name = name
        self.brand = brand
        self.model = model
        self.year = year
        self.mechanicId = mechanicId
    }
    
    func addPart(_ part: PartWithAmount) {
        if let index = parts.firstIndex(where: { $0.id == part.id }) {
            parts[index] = part
            NotificationCenter.default.post(name: Notification.Name("budgetPartUpdated"), object: nil, userInfo: ["index": index, "budgetId": id])
        } else {
            parts.append(part)
            NotificationCenter.default.post(name: Notification.Name("budgetPartAdded"), object: nil, userInfo: ["index": parts.count - 1, "budgetId": id])
        }
    }
    
    func deletePart(id: String) {
        if let index = parts.firstIndex(where: { $0.id == id }) {
            parts.remove(at: index)
            NotificationCenter.default.post(name: Notification.Name("budgetPartDeleted"), object: nil, userInfo: ["index": index, "budgetId": id])
        }
    }
    
    func buildBudgetEmail() -> (subject: String, recipients: [String], body: String, cc: [String])? {
        guard let user = Model.instance.signedMechanic else {
            return nil
        }
        
        let subject: String = "Você tem produtos listados no orçamento (\(name)) de: \(user.name)"
        var body: String = "<h1>Lista De Peças</h1>"
        let recipients: [String] = [user.email]
        let cc: [String] = [user.email]
        
        parts.forEach { (part) in
            body += "<br><hr><br>"
            let nome = "<b>Nome:</b> \(part.name)<br>"
            let marca = "<b>Marca:</b> \(part.brand)<br>"
            let modelo = "<b>Modelo:</b> \(part.model)<br>"
            let ano = "<b>Ano:</b> \(part.year)<br>"
            let preco = "<b>Preço:</b>R$ \(part.price)<br>"
            let quantidade = "<b>Quantidade:</b> \(part.amount) \(part.amount == 1 ? "unidade" : "unidades")<br>"
            let fornecedorInfo = "<b>Id do fornecedor:</b> \(user.id)<br>"
            body += (nome + marca + modelo + ano + preco + quantidade + fornecedorInfo)
        }
        
        body += "<hr>"
        body += "<h1>Informações da oficina</h1>"
        body += "<b>Nome:</b>\(user.name)<br>"
        body += "<b>Email:</b><br>\(user.email)"
        body += "<b>Telefone:</b>\(user.phone)<br>"
        body += "<b>Endereço:</b>\(user.address)<br>"
        body += "<hr>"
        
        return (subject, recipients, body, cc)
    }
    
    func sendEmailsOrder(completion: @escaping (Error?) -> Void) {
        
    }

//    func buildOrders() -> [BudgetOrderStructure] {
//        var vendors = Set<String>()
//        parts.forEach({ vendors.insert($0.vendorId)})
//
//        var partsFromVendors = [PartsFromVendor]()
//        vendors.forEach { vendorId in
//            partsFromVendors.append(
//                PartsFromVendor(
//                    vendorId: vendorId,
//                    partsWithAmounts: parts.filter({ $0.vendorId == vendorId })
//                )
//            )
//        }
//
//        var orders = [BudgetOrderStructure]()
//        partsFromVendors.forEach { partsFromVendor in
//            orders.append(
//                BudgetOrderStructure(
//                    budgetId: self.id,
//                    vendorId: partsFromVendor.vendorId,
//                    mechanicId: self.mechanicId,
//                    createdAt: Date(),
//                    partsWithAmounts: partsFromVendor.partsWithAmounts,
//                    status: "Aberto",
//                    statusUpdatedAt: Date()
//                )
//            )
//        }
//
//        return orders
//    }
    
}

//struct BudgetOrderStructure {
//    var budgetId: String
//    var vendorId: String
//    var mechanicId: String
//    var createdAt: Date
//    var partsWithAmounts: [PartWithAmount]
//    var status: String
//    var statusUpdatedAt: Date
//}
//
//struct PartsFromVendor {
//    var vendorId: String
//    var partsWithAmounts: [PartWithAmount]
//}


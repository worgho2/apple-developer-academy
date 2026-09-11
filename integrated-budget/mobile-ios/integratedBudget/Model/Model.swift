import Foundation
import FirebaseDatabase
import FirebaseAuth

class Model {
    static let instance = Model()
    
    private var database: DatabaseReference = Database.database().reference()
    
    var signedVendor: Vendor?
    var signedMechanic: Mechanic?
    var inventory: Inventory?
    
    private init() {}
    
    func reset() {
        signedVendor = nil
        signedMechanic = nil
        inventory = nil
    }
    
    //MARK: Vendor
    func loadSignedVendorData(completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(CustomError.four)
            return
        }
        
        //MARK: create vendor
        database.child(UserCategory.vendor.rawValue).child(uid).observeSingleEvent(of: .value) { vendorSnapshot in
            guard
                vendorSnapshot.exists(),
                let data = vendorSnapshot.value as? NSDictionary,
                let email = data["email"] as? String,
                let name = data["name"] as? String,
                let phone = data["phone"] as? String,
                let address = data["address"] as? String
            else {
                completion(CustomError.three)
                return
            }
            
            self.signedVendor = Vendor(id: uid, name: name, email: email, phone: phone, address: address)
            completion(nil)
            
            //MARK: get vendor.parts references
            self.database.child(UserCategory.vendor.rawValue).child(uid).child("parts").observe(.childAdded) { vendorPartSnapshot in
                guard vendorPartSnapshot.exists() else { return }
                let partId = vendorPartSnapshot.key
                
                //MARK: add/update vendor.part
                self.database.child("part").child(partId).observe(.value) { partSnapshot in
                    if
                        partSnapshot.exists(),
                        let data = partSnapshot.value as? NSDictionary,
                        let name = data["name"] as? String,
                        let brand = data["brand"] as? String,
                        let model = data["model"] as? String,
                        let year = data["year"] as? Int,
                        let price = data["price"] as? Double,
                        let vendorId = data["vendor_id"] as? String,
                        let signedVendor = self.signedVendor
                    {
                        signedVendor.addPart(
                            Part(
                                id: partId,
                                name: name,
                                brand: brand,
                                model: model,
                                year: year,
                                price: price,
                                vendorId: vendorId,
                                vendorName: "TODO"
                            )
                        )
                    }
                }
            }
            
            //MARK: delete vendor.part
            self.database.child(UserCategory.vendor.rawValue).child(uid).child("parts").observe(.childRemoved) { vendorPartSnapshot in
                if
                    vendorPartSnapshot.exists(),
                    let signedVendor = self.signedVendor
                {
                    let partId = vendorPartSnapshot.key
                    signedVendor.deletePart(id: partId)
                }
            }
        }
        
        //update vendor data
        database.child(UserCategory.vendor.rawValue).child(uid).observe(.value) { vendorSnapshot in
            if
                vendorSnapshot.exists(),
                let data = vendorSnapshot.value as? NSDictionary,
                let email = data["email"] as? String,
                let name = data["name"] as? String,
                let phone = data["phone"] as? String,
                let address = data["address"] as? String,
                let signedVendor = self.signedVendor
            {
                signedVendor.updateInfo(name: name, email: email, phone: phone, address: address)
            }
        }
    }
    
    func updateVendorInfo(name: String, address: String, phone: String, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(CustomError.unexpected)
            return
        }
        
        let values: [String: Any] = [
            "name": name,
            "address": address,
            "phone": phone,
        ]
        
        database.child(UserCategory.vendor.rawValue).child(uid).updateChildValues(values) { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func updateVendorPart(id: String, name: String, brand: String, model: String, year: Int, price: Double,  completion: @escaping (Error?) -> Void) {
        let values: [String: Any] = [
            "name": name,
            "brand": brand,
            "model": model,
            "year": year,
            "price": Double(round(100 * price)/100)
        ]
        
        database.child("part").child(id).updateChildValues(values) { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func removeVendorPart(id: String, completion: @escaping (Error?) -> Void) {
        guard
            let userId = Auth.auth().currentUser?.uid
        else {
            completion(CustomError.unexpected)
            return
        }
        
        database.child(UserCategory.vendor.rawValue).child(userId).child("parts").child(id).removeValue { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            self.database.child("part").child(id).removeValue { error, _ in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }
    }
    
    func addVendorPart(name: String, brand: String, model: String, year: Int, price: Double, completion: @escaping (Error?) -> Void) {
        guard
            let userId = Auth.auth().currentUser?.uid
        else {
            completion(CustomError.unexpected)
            return
        }
        
        let values: [String: Any] = [
            "name": name,
            "brand": brand,
            "model": model,
            "year": year,
            "price": Double(round(100 * price)/100),
            "vendor_id": userId,
        ]
        
        database.child("part").childByAutoId().setValue(values) { error, databaseReference in
            if let error = error {
                completion(error)
                return
            }
            
            guard let partId = databaseReference.key else {
                completion(CustomError.unexpected)
                return
            }
            
            self.database.child(UserCategory.vendor.rawValue).child(userId).child("parts").child(partId).setValue(0) { error, _ in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
            
        }
    }
    
    //MARK: Mechanic
    func loadSignedMechanicData(completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(CustomError.four)
            return
        }
        
        database.child("config").observe(.value) { configSnapshot in
            guard
                configSnapshot.exists(),
                let data = configSnapshot.value as? NSDictionary,
                let mailServiceUrl = data["mail_service_url"] as? String
            else {
                return
            }
            
            MailServiceFacade.serviceUrl = mailServiceUrl
        }
        
        //MARK: create mechanic
        database.child(UserCategory.mechanic.rawValue).child(uid).observeSingleEvent(of: .value) { mechanicSnapshot in
            guard
                mechanicSnapshot.exists(),
                let data = mechanicSnapshot.value as? NSDictionary,
                let email = data["email"] as? String,
                let name = data["name"] as? String,
                let phone = data["phone"] as? String,
                let address = data["address"] as? String
            else {
                completion(CustomError.unexpected)
                return
            }
            
            self.signedMechanic = Mechanic(id: uid, name: name, email: email, phone: phone, address: address)
            completion(nil)
            
            //MARK: get mechanic.budgets references
            self.database.child(UserCategory.mechanic.rawValue).child(uid).child("budgets").observe(.childAdded) { mechanicBudgetSnapshot in
                guard mechanicBudgetSnapshot.exists() else { return }
                let budgetId = mechanicBudgetSnapshot.key
                
                //MARK: add/update budget
                self.database.child("budget").child(budgetId).observe(.value) { budgetSnapshot in
                    if
                        budgetSnapshot.exists(),
                        let data = budgetSnapshot.value as? NSDictionary,
                        let status = data["status"] as? String,
                        let name = data["name"] as? String,
                        let brand = data["brand"] as? String,
                        let model = data["model"] as? String,
                        let year = data["year"] as? Int,
                        let mechanicId = data["mechanic_id"] as? String,
                        let signedMechanic = self.signedMechanic
                    {
                        signedMechanic.addBudget(
                            Budget(
                                id: budgetId,
                                status: status,
                                name: name,
                                brand: brand,
                                model: model,
                                year: year,
                                mechanicId: mechanicId
                            )
                        )
                    }
                }
                
                //MARK: get budget.parts references
                self.database.child("budget").child(budgetId).child("parts").observe(.childAdded) { budgetPartSnapshot in
                    guard
                        budgetPartSnapshot.exists(),
                        let partAmount = budgetPartSnapshot.value as? Int
                    else { return }
                    let partId = budgetPartSnapshot.key
                    
                    
                    
                    //MARK: add/update budget.part
                    self.database.child("part").child(partId).observe(.value) { partSnapshot in
                        if
                            partSnapshot.exists(),
                            let data = partSnapshot.value as? NSDictionary,
                            let name = data["name"] as? String,
                            let brand = data["brand"] as? String,
                            let model = data["model"] as? String,
                            let year = data["year"] as? Int,
                            let price = data["price"] as? Double,
                            let vendorId = data["vendor_id"] as? String,
                            let signedMechanic = self.signedMechanic
                        {
                            self.database.child(UserCategory.vendor.rawValue).child(vendorId).child("name").observeSingleEvent(of: .value) { vendorNameSnapshot in
                                if
                                    vendorNameSnapshot.exists(),
                                    let vendorName = vendorNameSnapshot.value as? String
                                {
                                    signedMechanic.addBudgetPart(budgetId: budgetId, part: PartWithAmount(
                                        id: partId,
                                        name: name,
                                        brand: brand,
                                        model: model,
                                        year: year,
                                        price: price,
                                        amount: partAmount,
                                        vendorId: vendorId,
                                        vendorName: vendorName
                                    ))
                                }
                                    
                            }
                        }
                    }
                }
                
                
                //MARK: update budget.parts amount
                self.database.child("budget").child(budgetId).child("parts").observe(.childChanged) { budgetPartSnapshot in
                    guard
                        budgetPartSnapshot.exists(),
                        let partAmount = budgetPartSnapshot.value as? Int
                    else { return }
                    let partId = budgetPartSnapshot.key
                    
                    
                    
                    //MARK: add/update budget.part
                    self.database.child("part").child(partId).observe(.value) { partSnapshot in
                        if
                            partSnapshot.exists(),
                            let data = partSnapshot.value as? NSDictionary,
                            let name = data["name"] as? String,
                            let brand = data["brand"] as? String,
                            let model = data["model"] as? String,
                            let year = data["year"] as? Int,
                            let price = data["price"] as? Double,
                            let vendorId = data["vendor_id"] as? String,
                            let signedMechanic = self.signedMechanic
                        {
                            self.database.child(UserCategory.vendor.rawValue).child(vendorId).child("name").observeSingleEvent(of: .value) { vendorNameSnapshot in
                                if
                                    vendorNameSnapshot.exists(),
                                    let vendorName = vendorNameSnapshot.value as? String
                                {
                                    signedMechanic.addBudgetPart(budgetId: budgetId, part: PartWithAmount(
                                        id: partId,
                                        name: name,
                                        brand: brand,
                                        model: model,
                                        year: year,
                                        price: price,
                                        amount: partAmount,
                                        vendorId: vendorId,
                                        vendorName: vendorName
                                    ))
                                }
                                    
                            }
                        }
                    }
                }
                
                //MARK: delete budget.part
                self.database.child("budget").child(budgetId).child("parts").observe(.childRemoved) { budgetPartSnapshot in
                    if
                        budgetPartSnapshot.exists(),
                        let signedMechanic = self.signedMechanic
                    {
                        signedMechanic.deleteBudgetPart(budgetId: budgetId, partId: budgetPartSnapshot.key)
                    }
                }
            }
            
            //MARK: delete mechanic.budget
            self.database.child(UserCategory.mechanic.rawValue).child(uid).child("budgets").observe(.childRemoved) { mechanicBudgetSnapshot in
                if
                    mechanicBudgetSnapshot.exists(),
                    let signedMechanic = self.signedMechanic
                {
                    signedMechanic.deleteBudget(id: mechanicBudgetSnapshot.key)
                }
            }
        }
        
        //MARK: update mechanic.(name/email/phone/address)
        database.child(UserCategory.mechanic.rawValue).child(uid).observe(.value) { mechanicSnapshot in
            if
                mechanicSnapshot.exists(),
                let data = mechanicSnapshot.value as? NSDictionary,
                let name = data["name"] as? String,
                let email = data["email"] as? String,
                let phone = data["phone"] as? String,
                let address = data["address"] as? String,
                let signedMechanic = self.signedMechanic
            {
                signedMechanic.updateInfo(name: name, email: email, phone: phone, address: address)
            }
        }
        
        loadInventoryData()
    }
    
    func updateMechanicInfo(name: String, address: String, phone: String, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(CustomError.unexpected)
            return
        }
        
        let values: [String: Any] = [
            "name": name,
            "address": address,
            "phone": phone,
        ]
        
        database.child(UserCategory.mechanic.rawValue).child(uid).updateChildValues(values) { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func updateMechanicBudget(id: String, status: String, name: String, brand: String, model: String, year: Int, completion: @escaping (Error?) -> Void) {
        let values: [String: Any] = [
            "status": status,
            "name": name,
            "brand": brand,
            "model": model,
            "year": year,
        ]
        
        database.child("budget").child(id).updateChildValues(values) { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func removeMechanicBudget(id: String, completion: @escaping (Error?) -> Void) {
        guard
            let userId = Auth.auth().currentUser?.uid
        else {
            completion(CustomError.unexpected)
            return
        }
        
        database.child(UserCategory.mechanic.rawValue).child(userId).child("budgets").child(id).removeValue { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            self.database.child("budget").child(id).removeValue { error, _ in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }
    }
    
    func addMechanicBudget(status: String, name: String, brand: String, model: String, year: Int, completion: @escaping (Error?) -> Void) {
        guard
            let userId = Auth.auth().currentUser?.uid
        else {
            completion(CustomError.unexpected)
            return
        }
        
        let values: [String: Any] = [
            "status": status,
            "name": name,
            "brand": brand,
            "model": model,
            "year": year,
            "mechanic_id": userId,
        ]
        
        database.child("budget").childByAutoId().setValue(values) { error, databaseReference in
            if let error = error {
                completion(error)
                return
            }
            
            guard let budgetId = databaseReference.key else {
                completion(CustomError.unexpected)
                return
            }
            
            self.database.child(UserCategory.mechanic.rawValue).child(userId).child("budgets").child(budgetId).setValue(0) { error, _ in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }
    }
    
    func addBudgetPart(budgetId: String, partId: String, amount: Int, completion: @escaping (Error?) -> Void) {
        database.child("budget").child(budgetId).child("parts").child(partId).observeSingleEvent(of: .value) { budgetPartSnapshot in
            var calculatedAmount = amount
            
            if
                budgetPartSnapshot.exists(),
                let storedAmount = budgetPartSnapshot.value as? Int
            {
                calculatedAmount += storedAmount
            }
            
            self.database.child("budget").child(budgetId).child("parts").child(partId).setValue(calculatedAmount) { error, _ in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
                return
            }
        }
    }
    
    func updateBudgetPart(budgetId: String, partId: String, amount: Int, completion: @escaping (Error?) -> Void) {
        database.child("budget").child(budgetId).child("parts").child(partId).setValue(amount) { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func removeBudgetPart(budgetId: String, partId: String, completion: @escaping (Error?) -> Void) {
        database.child("budget").child(budgetId).child("parts").child(partId).removeValue { error, _ in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func mechanicSendBudgetOrderEmails(budget: Budget) {
        guard let mechanic = self.signedMechanic else {
            print(CustomError.unexpected.localizedDescription)
            return
        }
        
        var vendors = Set<String>()
        budget.parts.forEach({ vendors.insert($0.vendorId)})
        
        for vendorId in vendors {
            self.database.child(UserCategory.vendor.rawValue).child(vendorId).observeSingleEvent(of: .value) { vendorSnapshot in
                guard
                    vendorSnapshot.exists(),
                    let data = vendorSnapshot.value as? NSDictionary,
                    let vendorEmail = data["email"] as? String,
                    let vendorName = data["name"] as? String
                else {
                    print(CustomError.unexpected.localizedDescription)
                    return
                }
                
                let parts = budget.parts.filter({$0.vendorId == vendorId})
                let price = String(format: "%.2f", parts.reduce(0) {return $0 + (Double($1.amount) * $1.price) })
                
                let to: String = vendorEmail
                let subject: String = "Solicitação de peças"
                
                var html = """
                <h1>Olá, \(vendorName)!</h1>
                <p>Uma oficina mecânica cadastrada no app Integrated Budget finalizou um orçamento, e algumas peças que você cadastrou foram solicitadas.</p>
                <p>&nbsp;</p>
                <h2>Dados do orçamento</h2>
                <p>Nome do cliente: \(budget.name)</p>
                <p>Marca do veículo: \(budget.brand)</p>
                <p>Modelo do veículo: \(budget.model)</p>
                <p>Ano do veículo: \(budget.year)</p>
                <p>&nbsp;</p>
                <h2>Suas peças solicitadas</h2>
                <p>&nbsp;</p>
                """
                
                for i in 0..<parts.count {
                    html += """
                    <h3>(\(i + 1))</h3>
                    <p>Nome: \(parts[i].name)</p>
                    <p>Marca: \(parts[i].brand)</p>
                    <p>Modelo: \(parts[i].model)</p>
                    <p>Ano: \(parts[i].year)</p>
                    <p>Quantidade: \(parts[i].amount)</p>
                    <p>Preço: \(String(format: "%.2f", parts[i].price))</p>
                    <p>&nbsp;</p>
                    """
                }
                
                html += """
                <h2>Dados para entrega</h2>
                <p>Nome: \(mechanic.name)</p>
                <p>Email: \(mechanic.email)</p>
                <p>Endereço: \(mechanic.address)</p>
                <p>Telefone: \(mechanic.phone)</p>
                <p>&nbsp;</p>
                <h1><strong>Valor total: R$ \(price)</strong></h1>
                """
                
                //MARK: ENVIAR ORÇAMENTO
                MailServiceFacade.sendEmail(to: to, subject: subject, html: html) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    print("Email enviado para \(to)", html)
                    return
                }
            }
        }
    }
    
    //MARK: Inventory
    func loadInventoryData() {
        self.inventory = Inventory()
        
        //MARK: add/update part
        database.child("part").observe(.childAdded) { partAddedSnapshot in
            let partId = partAddedSnapshot.key
            
            self.database.child("part").child(partId).observe(.value) { partSnapshot in
                if
                    partSnapshot.exists(),
                    let data = partSnapshot.value as? NSDictionary,
                    let name = data["name"] as? String,
                    let brand = data["brand"] as? String,
                    let model = data["model"] as? String,
                    let year = data["year"] as? Int,
                    let price = data["price"] as? Double,
                    let vendorId = data["vendor_id"] as? String,
                    let inventory = self.inventory
                {
                    self.database.child(UserCategory.vendor.rawValue).child(vendorId).child("name").observeSingleEvent(of: .value) { vendorNameSnapshot in
                        if
                            vendorNameSnapshot.exists(),
                            let vendorName = vendorNameSnapshot.value as? String
                        {
                            inventory.addPart(
                                Part(
                                    id: partSnapshot.key,
                                    name: name,
                                    brand: brand,
                                    model: model,
                                    year: year,
                                    price: price,
                                    vendorId: vendorId,
                                    vendorName: vendorName
                                )
                            )
                        }
                    }
                    
                }
            }
        }
        
        //MARK: delete part
        database.child("part").observe(.childRemoved) { partSnapshot in
            if
                partSnapshot.exists(),
                let inventory = self.inventory
            {
                inventory.deletePart(id: partSnapshot.key)
            }
        }
    }
}

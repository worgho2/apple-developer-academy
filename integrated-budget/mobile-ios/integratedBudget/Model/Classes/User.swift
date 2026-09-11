import Foundation

class User {
    var id: String
    var name: String
    var email: String
    var phone: String
    var address: String
    
    init(id: String, name: String, email: String, phone: String, address: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    func updateInfo(name: String? = nil, email: String? = nil, phone: String? = nil, address: String? = nil) {
        if let name = name {
            self.name = name
        }
        if let email = email {
            self.email = email
        }
        if let phone = phone {
            self.phone = phone
        }
        if let address = address {
            self.address = address
        }
    }
    
}


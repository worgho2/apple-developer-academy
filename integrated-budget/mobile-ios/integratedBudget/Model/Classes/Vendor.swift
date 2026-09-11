import Foundation

class Vendor: User {
    var parts: [Part] = []
    
    override func updateInfo(name: String? = nil, email: String? = nil, phone: String? = nil, address: String? = nil) {
        super.updateInfo(name: name, email: email, phone: phone, address: address)
        NotificationCenter.default.post(name: Notification.Name("vendorInfoUpdated"), object: nil)
    }
    
    func addPart(_ part: Part) {
        if let index = parts.firstIndex(where: { $0.id == part.id }) {
            parts[index] = part
            NotificationCenter.default.post(name: Notification.Name("vendorPartUpdated"), object: nil, userInfo: ["index": index])
        } else {
            parts.append(part)
            NotificationCenter.default.post(name: Notification.Name("vendorPartAdded"), object: nil, userInfo: ["index": parts.count - 1])
        }
    }
    
    func deletePart(id: String) {
        if let index = parts.firstIndex(where: { $0.id == id }) {
            parts.remove(at: index)
            NotificationCenter.default.post(name: Notification.Name("vendorPartDeleted"), object: nil, userInfo: ["index": index])
        }
    }
}

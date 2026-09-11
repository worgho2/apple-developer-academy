import Foundation

class Inventory {
    var parts: [Part] = []
    
    func addPart(_ part: Part) {
        if let index = parts.firstIndex(where: { $0.id == part.id }) {
            parts[index] = part
            NotificationCenter.default.post(name: Notification.Name("inventoryPartUpdated"), object: nil, userInfo: ["index": index])
        } else {
            parts.append(part)
            NotificationCenter.default.post(name: Notification.Name("inventoryPartAdded"), object: nil, userInfo: ["index": parts.count - 1])
        }
    }
    
    func deletePart(id: String) {
        if let index = parts.firstIndex(where: { $0.id == id }) {
            parts.remove(at: index)
            NotificationCenter.default.post(name: Notification.Name("inventoryPartDeleted"), object: nil, userInfo: ["index": index])
        }
    }
}

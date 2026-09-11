import Foundation

class Mechanic: User {
    var budgets: [Budget] = []
    
    override func updateInfo(name: String? = nil, email: String? = nil, phone: String? = nil, address: String? = nil) {
        super.updateInfo(name: name, email: email, phone: phone, address: address)
        NotificationCenter.default.post(name: Notification.Name("mechanicInfoUpdated"), object: nil)
    }
    
    func addBudget(_ budget: Budget) {
        if let index = budgets.firstIndex(where: { $0.id == budget.id }) {
            budget.parts = budgets[index].parts
            budgets[index] = budget
            NotificationCenter.default.post(name: Notification.Name("mechanicBudgetUpdated"), object: nil, userInfo: ["index": index])
        } else {
            budgets.append(budget)
            NotificationCenter.default.post(name: Notification.Name("mechanicBudgetAdded"), object: nil, userInfo: ["index": index])
        }
    }
    
    func deleteBudget(id: String) {
        if let index = budgets.firstIndex(where: { $0.id == id }) {
            budgets.remove(at: index)
            NotificationCenter.default.post(name: Notification.Name("mechanicBudgetDeleted"), object: nil, userInfo: ["index": index])
        }
    }
    
    func addBudgetPart(budgetId: String, part: PartWithAmount) {
        if let budget = budgets.first(where: {$0.id == budgetId}) {
            budget.addPart(part)
        }
    }
    
    func deleteBudgetPart(budgetId: String, partId: String) {
        if let budget = budgets.first(where: {$0.id == budgetId}) {
            budget.deletePart(id: partId)
        }
    }
}

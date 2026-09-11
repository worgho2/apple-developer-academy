import UIKit

class MechanicBudgetsTableViewController: UITableViewController {
    
    @IBOutlet weak var addBudgetButton: UIBarButtonItem!
    
    var lastSelectedBudgetId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            BudgetTableViewCell.nib,
            forCellReuseIdentifier: BudgetTableViewCell.identifier
        )
        areSubviewsEnabled(true)
        addDataObservers()
    }
    
    @IBAction func onAddBudgetButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddBudget", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vendor = Model.instance.signedMechanic else {
            return 0
        }
        
        return vendor.budgets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetTableViewCell.identifier, for: indexPath) as? BudgetTableViewCell,
            let mechanic = Model.instance.signedMechanic
        else {
            return UITableViewCell()
        }
        
        return cell.with(
            status: mechanic.budgets[indexPath.row].status,
            name: mechanic.budgets[indexPath.row].name,
            brand: mechanic.budgets[indexPath.row].brand,
            model: mechanic.budgets[indexPath.row].model,
            year: mechanic.budgets[indexPath.row].year
        )
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let mechanic = Model.instance.signedMechanic else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Excluir") { (action, view, handler) in
            Model.instance.removeMechanicBudget(id: mechanic.budgets[indexPath.row].id) { error in
                if let error = error {
                    self.presentErrorAlert(message: error.localizedDescription)
                    return
                }
                
                self.tableView.endEditing(true)
            }
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Editar") { (action, view, handler) in
            self.lastSelectedBudgetId = mechanic.budgets[indexPath.row].id
            self.performSegue(withIdentifier: "goToEditBudget", sender: self)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7647058824, blue: 0.2666666667, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.8621694446, green: 0.2072274387, blue: 0.2693366408, alpha: 1)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mechanic = Model.instance.signedMechanic else { return }
        self.lastSelectedBudgetId = mechanic.budgets[indexPath.row].id
        performSegue(withIdentifier: "goToBudget", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MechanicEditBudgetTableViewController {
            viewController.budgetId = self.lastSelectedBudgetId
            return
        }
        
        if let viewController = segue.destination as? MechanicBudgetInfoTableViewController {
            viewController.budgetId = self.lastSelectedBudgetId
        }
    }
}

extension MechanicBudgetsTableViewController {
    func addDataObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("mechanicBudgetAdded"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("mechanicBudgetUpdated"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("mechanicBudgetDeleted"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
    }
}

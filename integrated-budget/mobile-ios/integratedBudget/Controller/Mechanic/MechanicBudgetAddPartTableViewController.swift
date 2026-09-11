import UIKit

class MechanicBudgetAddPartTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            PartTableViewCell.nib,
            forCellReuseIdentifier: PartTableViewCell.identifier
        )
        areSubviewsEnabled(true)
        addDataObservers()
    }
    
    var filteredParts: [Part] {
        get {
            guard let inventory = Model.instance.inventory else {
                return []
            }
            
            guard
                let searchText = searchBar.text,
                !searchText.isEmpty
            else {
                return inventory.parts
            }
            
            return inventory.parts.filter { part in
                return [
                    part.name,
                    part.brand,
                    part.model,
                    String(part.year),
                    String(part.price)
                ]
                .map({ $0.lowercased() })
                .contains(where: { $0.contains(searchText.lowercased()) })
            }
        }
    }
    
    var budgetId: String?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredParts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PartTableViewCell.identifier, for: indexPath) as! PartTableViewCell
        
        return cell.with(
            name: filteredParts[indexPath.row].name,
            brand: filteredParts[indexPath.row].brand,
            model: filteredParts[indexPath.row].model,
            year: filteredParts[indexPath.row].year,
            price: filteredParts[indexPath.row].price,
            vendorName: filteredParts[indexPath.row].vendorName
        )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let budgetId = self.budgetId,
            let mechanic = Model.instance.signedMechanic,
            let budgetName = mechanic.budgets.first(where: {$0.id == budgetId})?.name
        else { return }
        let part = self.filteredParts[indexPath.row]
        
        let message = "Adicionar item (\(part.name) - \(part.brand) | \(part.model) | \(part.year)) no orçamento (\(budgetName))"
        
        let confirmationController = UIAlertController(title: "Confirmar?", message: message, preferredStyle: .alert)
        
        confirmationController.addTextField { textField in
            textField.placeholder = "Quantidade"
            textField.text = "1"
            textField.keyboardType = .numberPad
        }

        confirmationController.addAction(UIAlertAction(title: "Não", style: .cancel))
        confirmationController.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
            confirmationController.dismiss(animated: false) {
                guard
                    let amountText = confirmationController.textFields?[0].text,
                    let amount = Int(amountText),
                    amount > 0
                else {
                    self.presentErrorAlert(message: "É necessário informa a quantidade")
                    return
                }
                
                self.presentLoadingAlert(with: "Adicionando...")
                
                Model.instance.addBudgetPart(budgetId: budgetId, partId: part.id, amount: amount) { error in
                    self.dismissLoadingAlert {
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        if let navigationController = self.navigationController {
                            navigationController.popViewController(animated: true)
                        }
                    }
                    
                }
            }
            
        }))
        
        
        
        self.present(confirmationController, animated: true)
    }
}

extension MechanicBudgetAddPartTableViewController {
    func addDataObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("inventoryPartAdded"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("inventoryPartUpdated"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("inventoryPartDeleted"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
    }
}

extension MechanicBudgetAddPartTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

import UIKit

class MechanicBudgetInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var addPartButton: UIBarButtonItem!
    
    var budgetId: String?
    var budgetInfoArray: [(name: String, detail: String)] = []
    var actionsArray: [(name: String, isActive:Bool, handler: () -> ())] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            PartWithAmountTableViewCell.nib,
            forCellReuseIdentifier: PartWithAmountTableViewCell.identifier
        )
        areSubviewsEnabled(true)
        setupObservers()
        fillInfo()
    }
    
    func fillInfo() {
        guard
            let mechanic = Model.instance.signedMechanic,
            let budget = mechanic.budgets.first(where: {$0.id == budgetId})
        else {
            presentErrorAlert(message: "Erro ao carregar dados do usuário")
            return
        }
        
        addPartButton.isEnabled = budget.status == "Aberto"
        
        budgetInfoArray = [
            ("Nome do cliente", budget.name),
            ("Marca do veículo", budget.brand),
            ("Model do veículo", budget.model),
            ("Ano do veículo", String(budget.year)),
            ("Status", budget.status),
            ("Valor total", "R$ \(String(format: "%.2f", budget.parts.reduce(0) {return $0 + (Double($1.amount) * $1.price) }))"),
        ]
        
        actionsArray = [
            ("Editar Informações", true, {
                self.performSegue(withIdentifier: "goToEditBudget", sender: self)
            }),
            ("Concluir Orçamento", budget.status == "Aberto", {
                let closeController = UIAlertController(title: "Concluir Orçamento?", message: "Todos as peças serão encomendadas com os respectivos fornecedores. Cada fornecedor receberá um email de solicitação", preferredStyle: .alert)
                closeController.addAction(UIAlertAction(title: "Não", style: .default))
                closeController.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { _ in
                    
                    self.presentLoadingAlert(with: "Enviando...")
                    
                    Model.instance.mechanicSendBudgetOrderEmails(budget: budget)
                    
                    Model.instance.updateMechanicBudget(id: budget.id, status: "Fechado", name: budget.name, brand: budget.brand, model: budget.model, year: budget.year) { error in
                        self.dismissLoadingAlert {
                            if let error = error {
                                self.presentErrorAlert(message: error.localizedDescription)
                                return
                            }
                            
                            return
                        }
                    }
                }))
                
                self.present(closeController, animated: true)
            })
        ]
    }
    
    
    @IBAction func onAddPartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddBudgetPart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MechanicBudgetAddPartTableViewController {
            viewController.budgetId = budgetId
        }
        
        if let viewController = segue.destination as? MechanicEditBudgetTableViewController {
            viewController.budgetId = self.budgetId
            return
        }
    }
}

extension MechanicBudgetInfoTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 60
        case 2:
            return 120
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Informações"
        case 1:
            return "Ações"
        case 2:
            return "Itens"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return budgetInfoArray.count
        case 1:
            return actionsArray.count
        case 2:
            guard
                let mechanic = Model.instance.signedMechanic,
                let budget = mechanic.budgets.first(where: {$0.id == budgetId})
            else {
                return 0
            }
            
            return budget.parts.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "infoCell")
            
            cell.selectionStyle = .none
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            cell.textLabel?.text = budgetInfoArray[indexPath.row].name
            cell.textLabel?.textColor = #colorLiteral(red: 0.1490196078, green: 0.2745098039, blue: 0.3254901961, alpha: 1)
            
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            cell.detailTextLabel?.text = budgetInfoArray[indexPath.row].detail
            
            
            return cell
            
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "actionCell")
            
            cell.accessoryType = .disclosureIndicator
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            cell.textLabel?.text = actionsArray[indexPath.row].name
            cell.textLabel?.textColor = #colorLiteral(red: 0.1490196078, green: 0.2745098039, blue: 0.3254901961, alpha: 1)
            
            if !actionsArray[indexPath.row].isActive {
                cell.isUserInteractionEnabled = false
                cell.contentView.subviews.forEach({$0.alpha = 0.2})
            }
            
            return cell
            
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: PartWithAmountTableViewCell.identifier, for: indexPath) as? PartWithAmountTableViewCell,
                let mechanic = Model.instance.signedMechanic,
                let budget = mechanic.budgets.first(where: {$0.id == budgetId})
            else {
                return UITableViewCell()
            }
            
            return cell.with(
                name: budget.parts[indexPath.row].name,
                brand: budget.parts[indexPath.row].brand,
                model: budget.parts[indexPath.row].model,
                year: budget.parts[indexPath.row].year,
                price: budget.parts[indexPath.row].price,
                amount: budget.parts[indexPath.row].amount,
                vendorName: budget.parts[indexPath.row].vendorName
            )
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 { return nil }
        if indexPath.section == 1 { return nil }
        
        guard
            let mechanic = Model.instance.signedMechanic,
            let budget = mechanic.budgets.first(where: {$0.id == budgetId}),
            budget.status == "Aberto"
        else { return nil }
        
        let part = budget.parts[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Excluir") { (action, view, handler) in
            Model.instance.removeBudgetPart(budgetId: budget.id, partId: part.id) { error in
                if let error = error {
                    self.presentErrorAlert(message: error.localizedDescription)
                    return
                }
                
                self.tableView.endEditing(true)
            }
        }
        
        let editAction = UIContextualAction(style: .destructive, title: "Editar") { (action, view, handler) in
            let updateController = UIAlertController(title: "Quantidade", message: nil, preferredStyle: .alert)
            updateController.addTextField { textField in
                textField.placeholder = "Quantidade"
                textField.text = "\(part.amount)"
                textField.keyboardType = .numberPad
            }
            
            updateController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            updateController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                updateController.dismiss(animated: false) {
                    guard
                        let amountText = updateController.textFields?[0].text,
                        let amount = Int(amountText),
                        amount > 0
                    else {
                        self.presentErrorAlert(message: "É necessário informa a quantidade")
                        return
                    }
                    
                    Model.instance.updateBudgetPart(budgetId: budget.id, partId: part.id, amount: amount) { error in
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        self.tableView.endEditing(true)
                    }
                }
            }))
            
            self.present(updateController, animated: true)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7647058824, blue: 0.2666666667, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.8621694446, green: 0.2072274387, blue: 0.2693366408, alpha: 1)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if actionsArray[indexPath.row].isActive {
                actionsArray[indexPath.row].handler()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.1490196078, green: 0.2745098039, blue: 0.3254901961, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
}

extension MechanicBudgetInfoTableViewController {
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("mechanicBudgetUpdated"), object: nil, queue: .main) { notification in
            self.fillInfo()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("budgetPartAdded"), object: nil, queue: .main) { notification in
            self.fillInfo()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("budgetPartUpdated"), object: nil, queue: .main) { notification in
            self.fillInfo()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("budgetPartDeleted"), object: nil, queue: .main) { notification in
            self.fillInfo()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("mechanicInfoUpdated"), object: nil, queue: .main) { notification in
            self.fillInfo()
            self.tableView.reloadData()
        }
    }
}

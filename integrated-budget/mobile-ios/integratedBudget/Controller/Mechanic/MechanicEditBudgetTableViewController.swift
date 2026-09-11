import UIKit

class MechanicEditBudgetTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var brandTextField: UITextField! {
        didSet {
            brandTextField.delegate = self
        }
    }
    @IBOutlet weak var modelTextField: UITextField! {
        didSet {
            modelTextField.delegate = self
        }
    }
    @IBOutlet weak var yearTextField: UITextField! {
        didSet {
            yearTextField.delegate = self
        }
    }
    
    var budgetId: String?
    var budgetStatus: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areSubviewsEnabled(true)
        fillPage()
    }
    
    func fillPage() {
        if
            let mechanic = Model.instance.signedMechanic,
            let index = mechanic.budgets.firstIndex(where: {$0.id == budgetId })
        {
            budgetStatus = mechanic.budgets[index].status
            nameTextField.text = "\(mechanic.budgets[index].name)"
            brandTextField.text = "\(mechanic.budgets[index].brand)"
            modelTextField.text = "\(mechanic.budgets[index].model)"
            yearTextField.text = "\(mechanic.budgets[index].year)"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            onEditBudgetButton()
        }
    }
    
    func onEditBudgetButton() {
        view.endEditing(true)
        areSubviewsEnabled(false)
        
        guard
            let id = budgetId,
            let status = budgetStatus,
            let name = nameTextField.text,
            let brand = brandTextField.text,
            let model = modelTextField.text,
            let yearText = yearTextField.text,
            let year = Int(yearText),
            !name.isEmpty,
            !brand.isEmpty,
            !model.isEmpty,
            !yearText.isEmpty
        else {
            presentErrorAlert(message: "Todos os campos são obrigatórios")
            return
        }
        
        presentLoadingAlert(with: "Salvando...")
        
        Model.instance.updateMechanicBudget(id: id, status: status, name: name, brand: brand, model: model, year: year) { error in
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
}

extension MechanicEditBudgetTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let name = nameTextField.text,
            let brand = brandTextField.text,
            let model = modelTextField.text,
            let year = yearTextField.text
        else { return false }
        
        if name.isEmpty {
            nameTextField.becomeFirstResponder()
            return true
        }
        if brand.isEmpty {
            brandTextField.becomeFirstResponder()
            return true
        }
        if model.isEmpty {
            modelTextField.becomeFirstResponder()
            return true
        }
        if year.isEmpty {
            yearTextField.becomeFirstResponder()
            return true
        }
        
        view.endEditing(true)
        return true
    }
}

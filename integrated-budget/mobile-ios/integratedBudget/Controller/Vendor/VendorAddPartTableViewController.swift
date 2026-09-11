import UIKit

class VendorAddPartTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.becomeFirstResponder()
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
    @IBOutlet weak var priceTextField: UITextField! {
        didSet {
            priceTextField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        areSubviewsEnabled(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            onAddButton()
        }
    }
    
    func onAddButton() {
        view.endEditing(true)
        areSubviewsEnabled(false)
        
        guard
            let name = nameTextField.text,
            let brand = brandTextField.text,
            let model = modelTextField.text,
            let yearText = yearTextField.text,
            let priceText = priceTextField.text?.replacingOccurrences(of: ",", with: "."),
            let year = Int(yearText),
            let price = Double(priceText),
            !name.isEmpty,
            !brand.isEmpty,
            !model.isEmpty,
            !yearText.isEmpty,
            !priceText.isEmpty
        else {
            presentErrorAlert(message: "Todos os campos são obrigatórios")
            return
        }
        
        presentLoadingAlert(with: "Adicionando ...")
        
        Model.instance.addVendorPart(name: name, brand: brand, model: model, year: year, price: price) { error in
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

extension VendorAddPartTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let name = nameTextField.text,
            let brand = brandTextField.text,
            let model = modelTextField.text,
            let year = yearTextField.text,
            let price = priceTextField.text
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
        if price.isEmpty {
            priceTextField.becomeFirstResponder()
            return true
        }
        
        view.endEditing(true)
        return true
    }
}

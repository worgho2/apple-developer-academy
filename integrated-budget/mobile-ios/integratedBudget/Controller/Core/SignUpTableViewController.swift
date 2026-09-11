import UIKit

class SignUpTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet { nameTextField.delegate = self }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet { emailTextField.delegate = self }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet { passwordTextField.delegate = self }
    }
    @IBOutlet weak var addressTextField: UITextField! {
        didSet { addressTextField.delegate = self }
    }
    @IBOutlet weak var phoneTextField: UITextField! {
        didSet { emailTextField.delegate = self }
    }
    @IBOutlet weak var serviceTermsSwitch: UISwitch!
    @IBOutlet weak var userCategorySegmentedControl: UISegmentedControl! {
        didSet {
            userCategorySegmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
            userCategorySegmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.1490196078, green: 0.2745098039, blue: 0.3254901961, alpha: 1)], for: .normal)
        }
    }
    @IBOutlet weak var useTermsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areSubviewsEnabled(true)
        serviceTermsSwitch.setOn(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 7 {
            onSignUp()
        }
    }
    
    func onSignUp() {
        areSubviewsEnabled(false)
        print(userCategorySegmentedControl.selectedSegmentIndex)
        guard
            userCategorySegmentedControl.selectedSegmentIndex != -1,
            let category: UserCategory = userCategorySegmentedControl.selectedSegmentIndex == 0 ? .vendor : .mechanic,
            let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let phone = phoneTextField.text,
            let address = addressTextField.text,
            !name.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            !phone.isEmpty,
            !address.isEmpty
        else {
            presentErrorAlert(message: "Todos os campos são obrigatórios")
            return
        }
        
        if !serviceTermsSwitch.isOn {
            presentErrorAlert(message: "É necessário aceitar os Termos de Serviço")
            return
        }
        
        presentLoadingAlert(with: "Cadastrando...")
        
        AuthFacade.registerUser(category: category, email: email, password: password, name: name, address: address, phone: phone) { uid, error in
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
    
    
    @IBAction func onUseTermsButton(_ sender: Any) {
        
    }
}

extension SignUpTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let address = addressTextField.text,
            let phone = phoneTextField.text
        else { return false }
        
        if name.isEmpty {
            nameTextField.becomeFirstResponder()
            return true
        }
        if email.isEmpty {
            emailTextField.becomeFirstResponder()
            return true
        }
        if password.isEmpty {
            passwordTextField.becomeFirstResponder()
            return true
        }
        if address.isEmpty {
            addressTextField.becomeFirstResponder()
            return true
        }
        if phone.isEmpty {
            phoneTextField.becomeFirstResponder()
            return true
        }
        
        view.endEditing(true)
        return true
    }
}


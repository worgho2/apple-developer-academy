import UIKit

class VendorProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.isEnabled = false
            emailTextField.textColor = .placeholderText
        }
    }
    @IBOutlet weak var addressTextField: UITextField!{
        didSet {
            addressTextField.delegate = self
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet {
            phoneTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areSubviewsEnabled(true)
        setupObservers()
        fillInfo()
    }
    
    func fillInfo() {
        guard let vendor = Model.instance.signedVendor else {
            presentErrorAlert(message: "Erro ao carregar dados do usuário")
            return
        }
        
        nameTextField.text = vendor.name
        emailTextField.text = vendor.email
        addressTextField.text = vendor.address
        phoneTextField.text = vendor.phone
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        areSubviewsEnabled(false)
        
        guard
            let name = nameTextField.text,
            let address = addressTextField.text,
            let phone = phoneTextField.text,
            !name.isEmpty,
            !address.isEmpty,
            !phone.isEmpty
        else {
            presentErrorAlert(message: "Todos os campos são obrigatórios")
            return
        }
        
        presentLoadingAlert(with: "Salvando...")
        
        Model.instance.updateVendorInfo(name: name, address: address, phone: phone) { error in
            self.dismissLoadingAlert {
                if let error = error {
                    self.presentErrorAlert(message: error.localizedDescription)
                    return
                }
                
                self.fillInfo()
            }
        }
    }
    
    @IBAction func onSignOutButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Deseja mesmo sair?", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Não", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { _ in
            AuthFacade.deauthenticateUser { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.dismiss(animated: true)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: NOTIFICATION CENTER OBSERVERS
extension VendorProfileTableViewController {
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("vendorInfoUpdated"), object: nil, queue: .main) { notification in
            self.fillInfo()
        }
    }
}

extension VendorProfileTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let name = nameTextField.text,
            let address = addressTextField.text,
            let phone = phoneTextField.text
        else { return false }
        
        if name.isEmpty {
            nameTextField.becomeFirstResponder()
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

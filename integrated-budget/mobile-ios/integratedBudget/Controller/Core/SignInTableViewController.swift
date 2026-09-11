import UIKit

class SignInTableViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet { emailTextField.delegate = self }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet { passwordTextField.delegate = self }
    }
    @IBOutlet weak var signUpButton: UIBarButtonItem!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areSubviewsEnabled(true)
        
        presentLoadingAlert(with: "Carregando...")
        
        AuthFacade.verifyAlreadyAuthenticatedUser { userCategory in
            guard let userCategory = userCategory else {
                self.dismissLoadingAlert()
                return
            }
            
            if userCategory == .vendor {
                Model.instance.loadSignedVendorData { error in
                    self.dismissLoadingAlert {
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        self.performSegue(withIdentifier: "goToVendorDashboard", sender: self)
                    }
                }
            } else if userCategory == .mechanic {
                Model.instance.loadSignedMechanicData { error in
                    self.dismissLoadingAlert {
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        self.performSegue(withIdentifier: "goToMechanicDashboard", sender: self)
                    }
                }
            } else {
                self.presentErrorAlert(message: CustomError.unexpected.localizedDescription)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
        
        //MARK: DEBUG
        return 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            onSignIn()
        }
        
        //MARK: DEBUG
        if indexPath.row == 4 {
            emailTextField.text = "demo_vendor@mail.com"
            passwordTextField.text = "123456"
            onSignIn()
        }
        
        //MARK: DEBUG
        if indexPath.row == 5 {
            emailTextField.text = "demo_mechanic@mail.com"
            passwordTextField.text = "123456"
            onSignIn()
        }
    }
    
    func onSignIn() {
        areSubviewsEnabled(false)
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
        else {
            presentErrorAlert(message: "Todos os campos são obrigatórios")
            return
        }
        
        presentLoadingAlert(with: "Carregando ...")
        
        AuthFacade.authenticateUser(email: email, password: password) { userCategory, error in
            if let error = error {
                self.dismissLoadingAlert {
                    self.presentErrorAlert(message: error.localizedDescription)
                }
                return
            }
            
            if userCategory == .vendor {
                Model.instance.loadSignedVendorData { error in
                    self.dismissLoadingAlert {
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        self.performSegue(withIdentifier: "goToVendorDashboard", sender: self)
                    }
                }
            } else if userCategory == .mechanic {
                Model.instance.loadSignedMechanicData { error in
                    self.dismissLoadingAlert {
                        if let error = error {
                            self.presentErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        self.performSegue(withIdentifier: "goToMechanicDashboard", sender: self)
                    }
                }
            } else {
                self.dismissLoadingAlert {
                    self.presentErrorAlert(message: CustomError.five.localizedDescription)
                }
            }
        }
    }
}

extension SignInTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return false }
        
        if email.isEmpty {
            emailTextField.becomeFirstResponder()
            return true
        }
        if password.isEmpty {
            passwordTextField.becomeFirstResponder()
            return true
        }
        
        view.endEditing(true)
        return true
    }
}

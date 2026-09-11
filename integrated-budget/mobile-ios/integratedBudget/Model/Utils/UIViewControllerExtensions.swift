import UIKit

extension UIViewController {
    
    private static var loadingController: UIAlertController?
    
    func presentLoadingAlert(with message: String) {
        self.areSubviewsEnabled(false)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.view.addSubview(loadingIndicator)
        
        UIViewController.loadingController = alertController
        
        if let loadingController = UIViewController.loadingController {
            self.present(loadingController, animated: true)
        }
    }
    
    func dismissLoadingAlert(_ completion: (() -> Void)? = nil) {
        if let loadingController = UIViewController.loadingController {
            loadingController.dismiss(animated: true) {
                self.areSubviewsEnabled(true)
                if let completion = completion {
                    completion()
                }
            }
        } else {
            self.areSubviewsEnabled(true)
            if let completion = completion {
                completion()
            }
        }
    }

    func presentErrorAlert(message: String, handler: (() -> Void)? = nil) {
        self.areSubviewsEnabled(false)
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let handler = handler {
                handler()
            }
            self.areSubviewsEnabled(true)
        }))
        
        self.present(alertController, animated: true)
    }
    
    func areSubviewsEnabled(_ enabled: Bool) {
        self.view.subviews.forEach({
            if let item = $0 as? UIControl {
                item.isEnabled = enabled
            }
        })
        self.view.endEditing(true)
    }
    
    func dismissKeyboardOnTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
}

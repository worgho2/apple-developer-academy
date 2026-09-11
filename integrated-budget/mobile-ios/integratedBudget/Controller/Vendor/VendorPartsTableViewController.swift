import UIKit

class VendorPartsTableViewController: UITableViewController {
    
    @IBOutlet weak var addPartButton: UIBarButtonItem!
    
    var partIdForEditing: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            PartTableViewCell.nib,
            forCellReuseIdentifier: PartTableViewCell.identifier
        )
        
        areSubviewsEnabled(true)
        addDataObservers()
    }
    
    @IBAction func onAddPartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddPart", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vendor = Model.instance.signedVendor else {
            return 0
        }
        
        return vendor.parts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PartTableViewCell.identifier, for: indexPath) as? PartTableViewCell,
            let vendor = Model.instance.signedVendor
        else {
            return UITableViewCell()
        }
        
        return cell.with(
            name: vendor.parts[indexPath.row].name,
            brand: vendor.parts[indexPath.row].brand,
            model: vendor.parts[indexPath.row].model,
            year: vendor.parts[indexPath.row].year,
            price: vendor.parts[indexPath.row].price,
            vendorName: vendor.name
        )
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let vendor = Model.instance.signedVendor else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Excluir") { (action, view, handler) in
            Model.instance.removeVendorPart(id: vendor.parts[indexPath.row].id) { error in
                if let error = error {
                    self.presentErrorAlert(message: error.localizedDescription)
                    return
                }
                
                self.tableView.endEditing(true)
            }
        }

        deleteAction.backgroundColor = #colorLiteral(red: 0.8621694446, green: 0.2072274387, blue: 0.2693366408, alpha: 1)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vendor = Model.instance.signedVendor else { return }
        self.partIdForEditing = vendor.parts[indexPath.row].id
        self.performSegue(withIdentifier: "goToEditPart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? VendorEditPartTableViewController {
            viewController.partId = self.partIdForEditing
        }
    }
}

extension VendorPartsTableViewController {
    func addDataObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("vendorPartAdded"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("vendorPartUpdated"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("vendorPartDeleted"), object: nil, queue: .main) { notification in
            self.tableView.reloadData()
        }
    }
}

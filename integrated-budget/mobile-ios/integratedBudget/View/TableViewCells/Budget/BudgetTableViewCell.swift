import UIKit

class BudgetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var brandModelYearLabel: UILabel!
    
    func with(status: String, name: String, brand: String, model: String, year: Int) -> UITableViewCell {
        self.statusLabel.text = status
        self.nameLabel.text = name.capitalized
        self.brandModelYearLabel.text = "\(brand) | \(model) | \(year)"
        
        self.nameLabel.alpha = 1
        self.statusLabel.alpha = 0.6
        self.brandModelYearLabel.alpha = 0.6
        self.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        
        return self
    }
}

extension BudgetTableViewCell {
    static let identifier: String = "BudgetTableViewCell"
    static let nib: UINib = UINib(nibName: BudgetTableViewCell.identifier, bundle: nil)
}

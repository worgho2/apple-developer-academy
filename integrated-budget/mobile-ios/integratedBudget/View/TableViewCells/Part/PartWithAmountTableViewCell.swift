import UIKit

class PartWithAmountTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandModelYearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func with(name: String, brand: String, model: String, year: Int, price: Double, amount: Int, vendorName: String) -> UITableViewCell {
        self.nameLabel.text = name.capitalized
        self.brandModelYearLabel.text = "\(brand) | \(model) | \(year)"
        self.priceLabel.text = "R$ \(String(format: "%.2f", Double(amount) * price))"
        self.amountLabel.text = "\(amount) x R$ \(String(format: "%.2f", price)) de: \(vendorName)"
        
        self.nameLabel.alpha = 1
        self.amountLabel.alpha = 0.6
        self.brandModelYearLabel.alpha = 0.6
        self.priceLabel.alpha = 1
        
        self.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        return self
    }
}

extension PartWithAmountTableViewCell {
    static let identifier: String = "PartWithAmountTableViewCell"
    static let nib: UINib = UINib(nibName: PartWithAmountTableViewCell.identifier, bundle: nil)
}


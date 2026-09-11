import UIKit

class PartTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandModelYearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    func with(name: String, brand: String, model: String, year: Int, price: Double, vendorName: String) -> UITableViewCell {
        self.nameLabel.text = name.capitalized
        self.brandModelYearLabel.text = "\(brand) | \(model) | \(year)"
        self.priceLabel.text = "R$ \(price)"
        self.vendorNameLabel.text = "De: \(vendorName)"
        
        self.nameLabel.alpha = 1
        self.brandModelYearLabel.alpha = 0.6
        self.priceLabel.alpha = 1
        self.vendorNameLabel.alpha = 0.6
        self.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        
        return self
    }
}

extension PartTableViewCell {
    static let identifier: String = "PartTableViewCell"
    static let nib: UINib = UINib(nibName: PartTableViewCell.identifier, bundle: nil)
}

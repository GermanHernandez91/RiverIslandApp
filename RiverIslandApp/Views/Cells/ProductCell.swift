import UIKit

final class ProductCell : UITableViewCell {
    
    static let reuseId: String = .cellName
    
    // MARK: - Properties
    let productImage = ProductImage(frame: .zero)
    let nameLabel = TitleLabel(textAlignment: .left, size: 18)
    let priceLabel = BodyLabel(textAlignment: .left)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(product: ProductItemDto, repository: ProductsRepository) {
        nameLabel.text = product.name
        priceLabel.text = "£\(product.cost)"
        productImage.downloadAvatarImage(fromURL: product.image, repository: repository)
    }
}

// MARK: - Private implementation
private extension ProductCell {
    
    func configure() {
        accessoryType = .disclosureIndicator
        
        addSubview(nameLabel)
        addSubview(productImage)
        addSubview(priceLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            productImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            productImage.heightAnchor.constraint(equalToConstant: 90),
            productImage.widthAnchor.constraint(equalToConstant: 90),
            
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 24),
        ])
    }
}

fileprivate extension String {
    static let cellName = "ProductCell"
}

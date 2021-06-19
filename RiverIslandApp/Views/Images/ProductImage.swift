import UIKit

final class ProductImage: UIImageView {
    
    // MARK: - Properties
    let placeholderImage = UIImage(named: "placeholder")
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadAvatarImage(fromURL url: String, repository: ProductsRepository) {
        repository.fetchProductImage(with: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in self?.image = image }
        }
    }
}

// MARK: - Private implementation
private extension ProductImage {
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}

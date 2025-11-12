import UIKit


final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    private enum Constants {
        static let sideOffset: CGFloat = 16
        static let verticalOffset: CGFloat = 10
        static let buttonWidth: CGFloat = 140
        static let elementHeight: CGFloat = 44
        static let cornerRadius: CGFloat = 14
    }
    
    let wishCellText = UITextField()
    let addCellButton: UIButton = UIButton(type: .system)
    
    var addWish: ((String) -> ())?
        
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
                
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
                
        wishCellText.placeholder = "Введите желание"
        wishCellText.borderStyle = .roundedRect
        wishCellText.returnKeyType = .done
        wishCellText.isUserInteractionEnabled = true
                
        addCellButton.setTitle("Добавить желание", for: .normal)
        addCellButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        addCellButton.setTitleColor(.white, for: .normal)
        addCellButton.backgroundColor = .systemPink
        addCellButton.layer.cornerRadius = 10
        addCellButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
                
        contentView.addSubview(wishCellText)
        contentView.addSubview(addCellButton)
                
        wishCellText.pinLeft(to: contentView, Constants.sideOffset)
        wishCellText.pinTop(to: contentView, Constants.verticalOffset)
        wishCellText.pinBottom(to: contentView, Constants.verticalOffset)
        wishCellText.setHeight(mode: .equal, Constants.elementHeight)
                
        addCellButton.pinLeft(to: wishCellText.trailingAnchor, Constants.sideOffset)
        addCellButton.pinRight(to: contentView, Constants.sideOffset)
        addCellButton.pinVertical(to: contentView, Constants.verticalOffset)
        addCellButton.setWidth(mode: .equal, Constants.buttonWidth)

    }
    
    @objc
    private func addWishTapped() {
        let wishText = wishCellText.text ?? ""
        if wishText.isEmpty { return }
        addWish?(wishText)
        wishCellText.text = ""
        
    }
}


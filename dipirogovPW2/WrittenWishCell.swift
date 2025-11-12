import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        static let buttonSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 30
        static let editButtonTitle: String = "Red"
        static let deleteButtonTitle: String = "Del"
        static let editButtonFont : CGFloat = 14
        static let deleteButtonFont : CGFloat = 14
        static let editButtonColor: UIColor = .systemBlue
        static let deleteButtonColor: UIColor = .systemRed
        static let editButtonAlfaDef: CGFloat = 0
        static let deleteButtonAlfaDef: CGFloat = 0
        static let editButtonAlfaFull: CGFloat = 1
        static let deleteButtonAlfaFull: CGFloat = 1
        static let animDur : CGFloat = 0.25
    }
    
    private let wishLabel: UILabel = UILabel()
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private var buttonsVisible = false
    
    var editWish: (() -> Void)?
    var deleteWish: (() -> Void)?
        
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wishLabel.isUserInteractionEnabled = false
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.addSubview(wishLabel)
        
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
        editButton.setTitle(Constants.editButtonTitle, for: .normal)
        deleteButton.setTitle(Constants.deleteButtonTitle, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: Constants.editButtonFont, weight: .medium)
        deleteButton.titleLabel?.font = .systemFont(ofSize: Constants.deleteButtonFont, weight: .medium)
        editButton.setTitleColor(Constants.editButtonColor, for: .normal)
        deleteButton.setTitleColor(Constants.deleteButtonColor, for: .normal)
        editButton.alpha = Constants.editButtonAlfaDef
        deleteButton.alpha = Constants.deleteButtonAlfaDef
        editButton.isHidden = true
        deleteButton.isHidden = true
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
                
        wrap.addSubview(editButton)
        wrap.addSubview(deleteButton)
                
        wishLabel.pinLeft(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinVertical(to: wrap, Constants.wishLabelOffset)
                
        deleteButton.pinRight(to: wrap, Constants.wishLabelOffset)
        deleteButton.pinVertical(to: wrap, Constants.wishLabelOffset)
        deleteButton.setWidth(mode: .equal, Constants.buttonHeight)
        deleteButton.setHeight(mode: .equal, Constants.buttonHeight)
                
        editButton.pinRight(to: deleteButton.leadingAnchor, Constants.buttonSpacing)
        editButton.pinVertical(to: wrap, Constants.wishLabelOffset)
        editButton.setWidth(mode: .equal, Constants.buttonHeight)
        editButton.setHeight(mode: .equal, Constants.buttonHeight)
    }
    
    func setEditingMode(_ visible: Bool) {
           guard visible != buttonsVisible else { return }
           buttonsVisible = visible
           
        UIView.animate(withDuration: Constants.animDur) {
            self.editButton.isHidden = !visible
            self.deleteButton.isHidden = !visible
            self.editButton.alpha = visible ? Constants.editButtonAlfaFull : Constants.editButtonAlfaDef
            self.deleteButton.alpha = visible ? Constants.deleteButtonAlfaFull : Constants.deleteButtonAlfaDef
           }
       }
       
       @objc private func editTapped() {
           editWish?()
       }
       
       @objc private func deleteTapped() {
           deleteWish?()
       }
}

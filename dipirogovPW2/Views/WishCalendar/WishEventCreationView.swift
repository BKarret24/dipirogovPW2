import UIKit

final class WishEventCreationView: UIViewController {

    enum Constants {
            static let titlePlaceholder: String = "Имя"
            static let descriptionPlaceholder: String = "Описание"
            static let startText: String = "Начало"
            static let endText: String = "Конец"
            static let saveTitle: String = "Сохранить"
            
            static let stackSpacing: CGFloat = 12
            static let sideInset: Double = 20
        }
    
    var onSave: ((WishEventModel) -> Void)?
    
    var currentColor: UIColor = .white {
        didSet {
            view.backgroundColor = currentColor
        }
    }

    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let startPicker = UIDatePicker()
    private let endPicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    private let chooseWishButton = UIButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentColor
        configureUI()
    }

    private func configureUI() {
        chooseWishButton.setTitle("Выбрать желание из списка", for: .normal)
        chooseWishButton.addTarget(self, action: #selector(chooseWishTapped), for: .touchUpInside)
        titleField.placeholder = Constants.titlePlaceholder
        titleField.borderStyle = .roundedRect

        descriptionField.placeholder = Constants.descriptionPlaceholder
        descriptionField.borderStyle = .roundedRect

        startPicker.datePickerMode = .dateAndTime
        endPicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            startPicker.preferredDatePickerStyle = .wheels
            endPicker.preferredDatePickerStyle = .wheels
        }

        startPicker.addTarget(self, action: #selector(startChanged), for: .valueChanged)
        endPicker.minimumDate = startPicker.date

        saveButton.setTitle(Constants.saveTitle, for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        let startLabel = UILabel()
        startLabel.text = Constants.startText

        let endLabel = UILabel()
        endLabel.text = Constants.endText

        let stack = UIStackView(arrangedSubviews: [
            chooseWishButton,
            titleField,
            descriptionField,
            startLabel,
            startPicker,
            endLabel,
            endPicker,
            saveButton
        ])
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing

        view.addSubview(stack)
        stack.pinLeft(to: view, Constants.sideInset)
        stack.pinRight(to: view, Constants.sideInset)
        stack.pinCenterY(to: view)
    }

    @objc private func startChanged() {
        endPicker.minimumDate = startPicker.date
        if endPicker.date < startPicker.date {
            endPicker.date = startPicker.date
        }
    }

    @objc
    private func saveTapped() {
        let title = (titleField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }

        let model = WishEventModel(
            title: title,
            description: descriptionField.text ?? "",
            startDate: startPicker.date,
            endDate: endPicker.date
        )

        onSave?(model)
        dismiss(animated: true)
    }
    
    @objc
    private func chooseWishTapped() {
        let vc = WishStoringViewController()
        vc.isSelectionMode = true
        vc.onWishSelected = { [weak self] wish in
            self?.titleField.text = wish
        }

        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

}



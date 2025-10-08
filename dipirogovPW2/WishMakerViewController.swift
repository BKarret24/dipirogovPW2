import UIKit

final class WishMakerViewController: UIViewController {
    enum Constants {
    static let titleFontSize: CGFloat = 30
    static let titleLeadingDist: CGFloat = 20
    static let titleTopDist: CGFloat = 30
    static let descFontSize: CGFloat = 12
    static let descLeadingDist: CGFloat = 20
    static let descTopDist: CGFloat = 20
    static let sliderMin: Double = 0
    static let sliderMax: Double = 1
    static let red: String = "Red"
    static let green: String = "Green"
    static let blue: String = "Blue"
    static let AnimDur = 0.3
    static let stackRadius: CGFloat = 20
    static let stackBottom: CGFloat = -40
    static let stackLeading: CGFloat = 20
    static let stackColorTop: CGFloat = 120
    static let stackSpacing: CGFloat = 10
    static let stackColorBottom: CGFloat = 20
    static let stackColorLeading: CGFloat = 20
    static let stackColorTrailing: CGFloat = -20
    }
    
    private var backColor = ColorChanger()
    private var sliderStack = UIStackView()
    private let hexTextField = UITextField()
    private let randomColorButton = UIButton(type: .system)
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
    }
    
    private func ConfigureUI() {
        ConfigureColor()
        ConfigureTitle()
        configureSliders()
        configureHideButton()
        configureColorTools()
    }
    
    private func ConfigureColor() {
        view.backgroundColor = backColor.getColor()
    }
    
    private func ConfigureTitle() {
        let labelTitle = UILabel()
        labelTitle.text = "Wish Maker"
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        labelTitle.textColor = .magenta
        view.addSubview(labelTitle)
        ConfigureDesc(below: labelTitle)

        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeadingDist),
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopDist)
        ])
    }

    private func ConfigureDesc(below titleLabel: UILabel) {
        let labelDesc = UILabel()
        labelDesc.text = "But remember: The main performer of your dreams is you"
        labelDesc.translatesAutoresizingMaskIntoConstraints = false
        labelDesc.font = .systemFont(ofSize: Constants.descFontSize)
        labelDesc.textColor = .purple
        view.addSubview(labelDesc)

        NSLayoutConstraint.activate([
            labelDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descLeadingDist),
            labelDesc.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descTopDist)
        ])
    }
    
    
    private func configureSliders() {
    let stack = UIStackView()
    self.sliderStack = stack
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    view.addSubview(stack)
    stack.layer.cornerRadius = Constants.stackRadius
    stack.clipsToBounds = true
    let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    for slider in [sliderRed, sliderGreen, sliderBlue] {
    stack.addArrangedSubview(slider)
    }
    NSLayoutConstraint.activate([
    stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
    stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
    ])
        
    sliderRed.valueChanged = { [weak self] value in
        self?.backColor.changeRed(val: value)
        self?.ConfigureColor()
        }
    sliderBlue.valueChanged = { [weak self] value in
        self?.backColor.changeBlue(val: value)
        self?.ConfigureColor()
        }
    sliderGreen.valueChanged = { [weak self] value in
        self?.backColor.changeGreen(val: value)
        self?.ConfigureColor()
        }
    }
    
    private func configureHideButton() {
            let button = UIButton(type: .system)
            button.setTitle("Сместить слайдеры", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(hideSliders), for: .touchUpInside)
            view.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
    @objc
    private func hideSliders() {
        UIView.animate(withDuration: Constants.AnimDur) {
        self.sliderStack.isHidden.toggle()
        }
        }
    
    private func configureColorTools() {
            hexTextField.placeholder = "HEX цвет"
            hexTextField.borderStyle = .roundedRect
            hexTextField.autocapitalizationType = .none
            hexTextField.addTarget(self, action: #selector(applyHexColor), for: .editingDidEndOnExit)

            randomColorButton.setTitle("Случайный цвет", for: .normal)
            randomColorButton.addTarget(self, action: #selector(applyRandomColor), for: .touchUpInside)

            let stack = UIStackView(arrangedSubviews: [hexTextField, randomColorButton])
            stack.axis = .vertical
            stack.spacing = Constants.stackSpacing
            stack.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stack)

            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.stackColorTop),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackColorLeading),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.stackColorTrailing)
            ])
        }

        @objc
        private func applyHexColor() {
            guard let text = hexTextField.text else { return }
            backColor.setFromHex(text)
            ConfigureColor()
        }
    
        @objc
        private func applyRandomColor() {
            backColor.setRandom()
            ConfigureColor()
        }
}

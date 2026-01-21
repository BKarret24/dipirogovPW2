import UIKit

final class WishEventCell: UICollectionViewCell {

    private enum Constants {
        static let reuseIdentifier = "WishEventCell"
        static let outerPadding: Double = 8
        static let innerPadding: Double = 12
        static let cornerRadius: CGFloat = 16
        static let titleToDesc: Double = 6
        static let descToStart: Double = 10
        static let startToEnd: Double = 4
        static let titleFontSize: CGFloat = 18
        static let descFontSize: CGFloat = 14
        static let dateFontSize: CGFloat = 12
        static let titlePrefix: String = "Start Date: "
        static let endPrefix: String = "End Date: "
    }

    static let reuseIdentifier = Constants.reuseIdentifier
    private let wrapView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        startDateLabel.text = Constants.titlePrefix + formatter.string(from: event.startDate)
        endDateLabel.text = Constants.endPrefix + formatter.string(from: event.endDate)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
    }

    // MARK: - UI Configuration
    private func configureWrap() {
        contentView.addSubview(wrapView)
        wrapView.pinTop(to: contentView, Constants.outerPadding)
        wrapView.pinBottom(to: contentView, Constants.outerPadding)
        wrapView.pinLeft(to: contentView, Constants.outerPadding)
        wrapView.pinRight(to: contentView, Constants.outerPadding)

        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = .systemGray6
    }

    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        titleLabel.numberOfLines = 1

        titleLabel.pinTop(to: wrapView, Constants.innerPadding)
        titleLabel.pinLeft(to: wrapView, Constants.innerPadding)
        titleLabel.pinRight(to: wrapView, Constants.innerPadding)
    }

    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: Constants.descFontSize, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2

        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.titleToDesc)
        descriptionLabel.pinLeft(to: wrapView, Constants.innerPadding)
        descriptionLabel.pinRight(to: wrapView, Constants.innerPadding)
    }

    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.font = .systemFont(ofSize: Constants.dateFontSize, weight: .medium)
        startDateLabel.textColor = .tertiaryLabel
        startDateLabel.numberOfLines = 1

        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.descToStart)
        startDateLabel.pinLeft(to: wrapView, Constants.innerPadding)
        startDateLabel.pinRight(to: wrapView, Constants.innerPadding)
    }

    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.font = .systemFont(ofSize: Constants.dateFontSize, weight: .medium)
        endDateLabel.textColor = .tertiaryLabel
        endDateLabel.numberOfLines = 1

        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.startToEnd)
        endDateLabel.pinLeft(to: wrapView, Constants.innerPadding)
        endDateLabel.pinRight(to: wrapView, Constants.innerPadding)
        endDateLabel.pinBottom(to: wrapView, Constants.innerPadding, .lsOE)
    }
}


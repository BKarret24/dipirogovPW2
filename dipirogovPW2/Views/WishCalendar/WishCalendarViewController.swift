import UIKit

final class WishCalendarViewController: UIViewController {
    enum Constants {
        static let collectionTop: CGFloat = 20
        static let contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        static let title: String = "Wish Calendar"
        static let cellHeight: CGFloat = 150
        static let cellWidthInset: CGFloat = 10

    }
    
    private let store = WishEventStore()
    private var events: [WishEventModel] = []
    var currentColor: UIColor = .white {
        didSet {
            view.backgroundColor = currentColor
            collectionView.backgroundColor = currentColor
        }
    }
    
    private let collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentColor
        configureCollection()
        navigationItem.title = Constants.title
        navigationController?.navigationBar.tintColor = currentColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        events = store.fetchAll()
        collectionView.reloadData()
    }
    @objc
    private func addTapped() {
        let vc = WishEventCreationView()
        vc.currentColor = currentColor 
        vc.onSave = { [weak self] event in
            guard let self else { return }
            self.store.add(event)
            self.events = self.store.fetchAll()
            self.collectionView.reloadData()
        }
        present(vc, animated: true)
    }
    
    private func configureCollection() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.alwaysBounceVertical = true
    collectionView.showsVerticalScrollIndicator = false
    collectionView.contentInset = Constants.contentInset
    collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.pinHorizontal(to: view)
    collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    
    
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        events.count
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishCell = cell as? WishEventCell else { return cell }
        wishCell.configure(with: events[indexPath.item])
        return wishCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - Constants.cellWidthInset, height: Constants.cellHeight)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}

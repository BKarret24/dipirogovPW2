import UIKit

final class WishStoringViewController: UIViewController {
    
    enum Constants {
        static let tableCornerRadius: CGFloat = 10
        static let tableOffSet: CGFloat = 40
        static let sectionNumber: Int = 2
    }
    
    private let table : UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .systemGray3
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffSet)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)

    }
    
    
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addWishCell = cell as? AddWishCell else { return cell }
            addWishCell.addWish = { [weak self] wish in
                        guard let self = self else { return }
                        self.wishArray.append(wish)
                        self.table.reloadData()
                    }
            return addWishCell
        }
        else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionNumber
    }
}


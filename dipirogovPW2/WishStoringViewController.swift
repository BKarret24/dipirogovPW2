import UIKit

final class WishStoringViewController: UIViewController {
    
    enum Constants {
        static let tableCornerRadius: CGFloat = 10
        static let tableOffSet: CGFloat = 40
        static let sectionNumber: Int = 2
        static let wishesKey = "myWishes"
        static let AddWishSectionRows: Int = 1
        static let RedAlertText: String = "Редактировать желание"
        static let RedAlertCancel: String = "Отмена"
        static let RedAlertSave: String = "Сохранить"
    }
    
    private let table : UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    private var editingIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        if let stored = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = stored
        }
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .systemGray3
        table.dataSource = self
        table.separatorStyle = .none
        table.delegate = self
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
            return Constants.AddWishSectionRows
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
            defaults.set(wishArray, forKey: Constants.wishesKey)
            return addWishCell
        }
        else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            ) as! WrittenWishCell

            cell.configure(with: wishArray[indexPath.row])

            cell.editWish = { [weak self] in
                guard let self else { return }
                let alert = UIAlertController(title: Constants.RedAlertText, message: nil, preferredStyle: .alert)
                alert.addTextField { $0.text = self.wishArray[indexPath.row] }
                alert.addAction(UIAlertAction(title: Constants.RedAlertSave, style: .default) { _ in
                    if let text = alert.textFields?.first?.text {
                        self.wishArray[indexPath.row] = text
                        self.defaults.set(self.wishArray, forKey: Constants.wishesKey)
                        self.table.reloadRows(at: [indexPath], with: .automatic)
                    }
                })
                alert.addAction(UIAlertAction(title: Constants.RedAlertCancel, style: .cancel))
                self.present(alert, animated: true)
            }


            cell.deleteWish = { [weak self] in
                guard let self = self else { return }
                self.wishArray.remove(at: indexPath.row)
                self.defaults.set(self.wishArray, forKey: Constants.wishesKey)
                self.table.deleteRows(at: [indexPath], with: .automatic)
            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1,
              let cell = tableView.cellForRow(at: indexPath) as? WrittenWishCell else { return }
        
        if let prev = editingIndexPath,
           let prevCell = tableView.cellForRow(at: prev) as? WrittenWishCell,
           prev != indexPath {
            prevCell.setEditingMode(false)
        }
        
        let isNowVisible = !(editingIndexPath == indexPath)
        editingIndexPath = isNowVisible ? indexPath : nil
        cell.setEditingMode(isNowVisible)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionNumber
    }
}

extension WishStoringViewController: UITableViewDelegate {}



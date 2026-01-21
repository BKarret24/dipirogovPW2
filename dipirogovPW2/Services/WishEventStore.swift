import CoreData

final class WishEventStore {
    private let context = CoreDataStack.shared.context

    func fetchAll() -> [WishEventModel] {
        let request: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()

        do {
            let items = try context.fetch(request)
            return items.map {
                WishEventModel(
                    title: $0.title ?? "",
                    description: $0.desc ?? "",
                    startDate: $0.startDate ?? Date(),
                    endDate: $0.endDate ?? Date()
                )
            }
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    func add(_ model: WishEventModel) {
        let item = WishEvent(context: context)
        item.title = model.title
        item.desc = model.description
        item.startDate = model.startDate
        item.endDate = model.endDate
        CoreDataStack.shared.saveContext()
    }
}


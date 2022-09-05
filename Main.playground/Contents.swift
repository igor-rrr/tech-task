import UIKit

protocol MobileStorage {
  func getAll() -> Set<Mobile>
  func findByImei(_ imei: String) -> Mobile?
  func save(_ mobile: Mobile) throws -> Mobile
  func delete(_ product: Mobile) throws
  func exists(_ product: Mobile) -> Bool
}

struct Mobile {
  let imei: String
  let model: String
}

extension Mobile: Hashable {
  static func == (lhs: Mobile, rhs: Mobile) -> Bool {
    lhs.imei == rhs.imei
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(imei)
  }
}

// Implementation

class MobileStorageImp: MobileStorage {
  enum Error: Swift.Error {
    case mobileIsExisted
    case mobileIsNotExisted
  }

  var storage = Set<Mobile>()

  func getAll() -> Set<Mobile> {
    storage
  }

  func findByImei(_ imei: String) -> Mobile? {
    storage.first { $0.imei == imei }
  }

  func save(_ mobile: Mobile) throws -> Mobile {
    let (result, _) = storage.insert(mobile)
    if result {
      return mobile
    } else {
      throw Error.mobileIsExisted
    }
  }

  func delete(_ product: Mobile) throws {
    guard storage.remove(product) != nil else {
      throw Error.mobileIsNotExisted
    }
  }

  func exists(_ product: Mobile) -> Bool {
    storage.contains(product)
  }
}

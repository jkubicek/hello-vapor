import Vapor
import Foundation

final class User {
  var firstName: String?
  var lastName: String?
  let id: NSUUID
  
  init(firstName: String?, lastName: String?) {
    self.firstName = firstName
    self.lastName = lastName
    self.id = NSUUID()
  }
  
  init(id: NSUUID) {
    self.id = id
  }
}

/**
	This allows instances of User to be
	passed into Json arrays and dictionaries
	as if it were a native JSON type.
 */
extension User: JSONRepresentable {
  func makeJson() -> JSON {
    return JSON([
      "firstName": "\(firstName)",
      "lastName": "\(lastName)",
      "id": id.uuidString
      ])
  }
}

/**
	If a data structure is StringInitializable,
	it's Type can be passed into type-safe routing handlers.
 */
extension User: StringInitializable {
  convenience init?(from string: String) throws {
    guard let id = NSUUID(uuidString: string) else {
      throw "Could not create User object from string: \(string)"
    }
    self.init(id: id)
  }
}

extension User: ResponseRepresentable {
  func makeResponse() -> Response {
    return self.makeJson().makeResponse()
  }
}
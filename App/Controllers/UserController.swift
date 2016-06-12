import Vapor

class UserController: Controller {
  typealias Item = User
  
  required init(application: Application) {
    Log.info("User controller created")
  }
  
  deinit {
    Log.info("Deinit controller")
  }
  
  func index(_ request: Request) throws -> ResponseRepresentable {
    return JSON(users.map{$0})
  }
  
  func store(_ request: Request) throws -> ResponseRepresentable {
    let user = User(firstName: request.data["firstName"]?.string,
                    lastName: request.data["lastName"]?.string)
    users.append(user)
    return Response(status: .accepted)
  }
  
  /**
   Since item is of type User,
   only instances of user will be received
   */
  func show(_ request: Request, item user: User) throws -> ResponseRepresentable {
    //User can be used like JSON with JsonRepresentable
    return JSON([
      "controller": "UserController.show",
      "user": user
      ])
  }
  
  func update(_ request: Request, item user: User) throws -> ResponseRepresentable {
    //User is JsonRepresentable
    return user.makeJson()
  }
  
  func destroy(_ request: Request, item user: User) throws -> ResponseRepresentable {
    do {
      users = try users.removeElement(element: user)
      return Response(status: .ok)
    } catch {
      return Response(status: .badRequest, text: "\(error)")
    }
  }
  
}

extension User: Equatable {}

func ==(lhs: User, rhs: User) -> Bool {
  return lhs.id == rhs.id
}

extension String: ErrorProtocol { }

extension Array where Element: Equatable {
  
  func removeElement(element: Element) throws -> Array<Element> {
    guard let indexToRemove = index(of: element) else {
      throw "Could not find element \(element)"
    }
    var array = self
    array.remove(at: indexToRemove)
    return array
  }
  
}

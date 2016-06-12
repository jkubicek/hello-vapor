//
//  LinuxCompatibility.swift
//  VaporApp
//
//  Created by Jim Kubicek on 6/11/16.
//
//

import Foundation

extension NSUUID {
  
#if os(Linux)
  
  public var uuidString: String {
    return self.UUIDString
  }
  
  public convenience init?(uuidString string: String) {
    self.init(UUIDString: String)
  }
  
#endif
  
}
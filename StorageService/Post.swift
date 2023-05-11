

import Foundation
import UIKit


public struct Post {
    public init(author: String? = nil, description: String? = nil, image: UIImage? = nil , lokes: Int? = nil, views: Int? = nil) {
        self.author = author
        self.description = description
        self.image = image
        self.lokes = lokes
        self.views = views
    }
    
    public var author: String?
    public var description: String?
    public var image: UIImage?
    public var lokes: Int?
    public var views: Int?
    
}

public var postData = [Post]()

//public func addGeocache(_ newGeocache: Post, at index: Int) {
//    postData.insert(newGeocache, at: index)
//}

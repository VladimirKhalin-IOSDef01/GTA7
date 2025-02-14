//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift

public struct MegastarMainItemsDataParser: Codable {
    
    public let data: [MegastarMainItemParser]
    
    enum MegastarCodingKeysAndRename: String, CodingKey {
      //  case data = "ubsakvasn16"
        case data = "avsjvna0"
        
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        data = try container.decode([MegastarMainItemParser].self, forKey: .data)
    }
}

public struct MegastarMainItemParser: Codable {
    
    public let title: String
    public let type: String
    public let imagePath: String
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
      //  case title = "CASKm6"
     //   case type = "CASKm7"
      //  case imagePath = "CASKm8"
        case title = "avsjvna1"
        case type = "avsjvna2"
        case imagePath = "avsjvna3"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        title = try container.decode(String.self, forKey: .title)
        type = try container.decode(String.self, forKey: .type)
        imagePath = try container.decode(String.self, forKey: .imagePath)
    }
    
}

public struct MegastarMainItem {
    
    public var title: String = ""
    public var type: String = ""
    public var imagePath: String = ""
    public var typeItem: MegastarMenuItemType
    
    init(title: String, type: String, imagePath: String, typeItem: MegastarMenuItemType) {
        self.title = title
        self.type = type
        self.imagePath = imagePath
        self.typeItem = typeItem
    }
}

public enum MegastarMenuItemType: String, Decodable {
    
    case main, gameSelection
    //, gameList
}

public final class MegastarMainItemObject: Object {
    // ref 05
    private let randomValues5 = (1...30).map { _ in Int.random(in: 300...400) }
    // ref 05
    
    @objc dynamic var title: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var imagePath: String = ""
    // ref 06
    private let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
    // ref 06
    @objc dynamic var rawTypeItem: String = ""
    public var typeItem: MegastarMenuItemType {
        
        MegastarMenuItemType(rawValue: rawTypeItem) ?? .main
        // MenuItemType(rawValue: rawTypeItem) ?? .gameSelection
    }
    
    convenience init(
        title: String,
        type: String,
        imagePath: String,
        rawTypeItem: String
    ) {
        self.init()
        self.title = title
        self.type = type
        self.imagePath = imagePath
        self.rawTypeItem = rawTypeItem
        
    }
    
    var lightweightRepresentation: MegastarMainItem {
        
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        
        return MegastarMainItem(title: title, type: type, imagePath: imagePath, typeItem: typeItem)
        
    }
    
}

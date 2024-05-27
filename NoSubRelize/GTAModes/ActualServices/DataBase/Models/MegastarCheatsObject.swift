//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift

struct MegastarCheatCodeParser: Codable {
    let name: String
    let code: [String]
    let filterTitle: String
    
    private enum MegastarCodingKeysAndRename : String, CodingKey {
        case name = "fkasn512cs"
        case code = "fkasn512cv"
        case filterTitle = "title"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
      
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode([String].self, forKey: .code)
        filterTitle = try container.decode(String.self, forKey: .filterTitle)
    }
}

struct MegastarCheatCodesPlatformParser: Codable {
    let ps: [MegastarCheatCodeParser]
    let xbox: [MegastarCheatCodeParser]
    let pc: [MegastarCheatCodeParser]?
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case ps = "playstation"
        case xbox = "xbox"
        case pc = "pc"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        ps = try container.decode([MegastarCheatCodeParser].self, forKey: .ps)
        xbox = try container.decode([MegastarCheatCodeParser].self, forKey: .xbox)
        pc = try container.decodeIfPresent([MegastarCheatCodeParser].self, forKey: .pc)
    }
}

struct MegastarCheatCodesGTA5Parser: Codable {
    let GTA5: MegastarCheatCodesPlatformParser
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case GTA5 = "kvaskvasvn"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        GTA5 = try container.decode(MegastarCheatCodesPlatformParser.self, forKey: .GTA5)
    }
}

struct MegastarCheatCodesGTA6Parser: Codable {
    
    let GTA6: MegastarCheatCodesPlatformParser
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case GTA6 = "kvaskvasvn"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        GTA6 = try container.decode(MegastarCheatCodesPlatformParser.self, forKey: .GTA6)
    }
}

struct MegastarCheatCodesGTASAParser: Codable {
    let GTA_San_Andreas: MegastarCheatCodesPlatformParser
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case GTA_San_Andreas = "kvaskvasvn"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        GTA_San_Andreas = try container.decode(MegastarCheatCodesPlatformParser.self, forKey: .GTA_San_Andreas)
    }
}

struct MegastarCheatCodesGTAVCParser: Codable {
    let GTA_Vice_City: MegastarCheatCodesPlatformParser
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case GTA_Vice_City = "kvaskvasvn"
    }
    // Кастомный инициализатор, использующий CodingKeys_andRename
    init(from decoder: Decoder) throws {
   
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        GTA_Vice_City = try container.decode(MegastarCheatCodesPlatformParser.self, forKey: .GTA_Vice_City)
    }
}

public struct MegastarCheatItem {
    
    var name: String = ""
    var code: [String] = []
    var filterTitle: String = ""
    var platform: String = ""
    var game: String = ""
    var isFavorite: Bool = false
    
    init(name: String, code: [String], filterTitle: String, platform: String, game: String, isFavorite: Bool) {
        self.name = name
        self.code = code
        self.filterTitle = filterTitle
        self.platform = platform
        self.game = game
        self.isFavorite = isFavorite
    }
}

public final class MegastarCheatObject: Object {
    
    @objc dynamic private(set) var id: String = UUID().uuidString.lowercased()
    @objc dynamic var name: String = ""
    var code = List<String>()
    @objc dynamic var filterTitle: String = ""
    @objc dynamic var platform: String = ""
    @objc dynamic var game: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override public static func primaryKey() -> String? {
        return #keyPath(MegastarCheatObject.id)
    }
    
    convenience init(
        name: String,
        code: [String],
        filterTitle: String,
        platform: String,
        game: String,
        isFavorite: Bool
    ) {
        self.init()
        self.name = name
        self.code.append(objectsIn: code)
        self.filterTitle = filterTitle
        self.platform = platform
        self.game = game
        self.isFavorite = isFavorite
    }
    
    var lightweightRepresentation: MegastarCheatItem {
        return MegastarCheatItem(
            name: name,
            code: Array(code),
            filterTitle: filterTitle,
            platform: platform,
            game: game,
            isFavorite: isFavorite
        )
    }
}

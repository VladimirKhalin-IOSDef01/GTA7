//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift

struct MegastarMod_Parser: Codable {
    let title: String
    let description: String
    let image: String
    
    let mod: String
    let filterTitle: String
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case title = "bqxl6q_f2"
        case description = "bqxl6q_t3"
        case image = "bqxl6q_i1"
        case mod = "bqxl6q_d4"
        case filterTitle = "filter"
    }
    init(from decoder: Decoder) throws {
  
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        mod = try container.decode(String.self, forKey: .mod)
        filterTitle = try container.decode(String.self, forKey: .filterTitle)
    }
}

struct MegastarGTA5_Mods: Codable {
    let GTA5: [String: [MegastarMod_Parser]]
  
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case GTA5 = "bqxl6q__ulg50"
    }
    init(from decoder: Decoder) throws {
     
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
        GTA5 = try container.decode([String: [MegastarMod_Parser]].self, forKey: .GTA5)
    }
}

public struct MegastarModItem {
    
    public var title: String = ""
    public var description: String = ""
    public var imagePath: String = ""
    public var modPath: String = ""
    public var filterTitle: String = ""

    init(
        title: String,
        description: String,
        imagePath: String,
        modPath: String,
        filterTitle: String
    ) {
        self.title = title
        self.description = description
        self.imagePath = imagePath
        self.modPath = modPath
        self.filterTitle = filterTitle
    }
}

public final class MegastarModObject: Object {
    
    @objc dynamic var titleMod: String = ""
    @objc dynamic var descriptionMod: String = ""
    @objc dynamic var imagePath: String = ""
    @objc dynamic var modPath: String = ""
    @objc dynamic var filterTitle: String = ""
    
    convenience init(
        titleMod: String,
        descriptionMod: String,
        imagePath: String,
        modPath: String,
        filterTitle: String
    ) {
        self.init()
        
        self.titleMod = titleMod
        self.descriptionMod = descriptionMod
        self.imagePath = imagePath
        self.modPath = modPath
        self.filterTitle = filterTitle
        
    }
    
    var lightweightRepresentation: MegastarModItem {
        return MegastarModItem(
            title: titleMod,
            description: descriptionMod,
            imagePath: imagePath,
            modPath: modPath,
            filterTitle: filterTitle
        )
    }
}




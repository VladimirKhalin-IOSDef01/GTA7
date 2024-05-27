//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift

    struct MegastarProjMissionCategory: Codable {
        let filter: String
        let name: String
    
        
        private enum MegastarCodingKeysAndRename: String, CodingKey {
            case filter
           // case name = "hfhju8900"
            case name = "kvsojsafc"
        }
        init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
                filter = try container.decode(String.self, forKey: .filter)
                name = try container.decode(String.self, forKey: .name)
            }
    }

    // Define the Checklist struct to hold the list of missions.
    struct MegastarChecklist: Codable {
        let missions: [MegastarProjMissionCategory]
        // Specify the coding keys to match JSON structure.
        private enum MegastarCodingKeysAndRename: String, CodingKey {
           // case missions = "Cheklist"
            case missions = "checklist"
        }
        init(from decoder: Decoder) throws {
               let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
               missions = try container.decode([MegastarProjMissionCategory].self, forKey: .missions)
           }
    }

struct MegastarRoot: Codable {
    let checklist: [MegastarProjMissionCategory]
    
    private enum CodingKeys: String, CodingKey {
        case checklist
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        checklist = try container.decode([MegastarProjMissionCategory].self, forKey: .checklist)
    }
}


/*
    struct MegastarRoot: Codable {
        let rnfwruhr: MegastarChecklist
        private enum MegastarCodingKeysAndRename: String, CodingKey {
            case rnfwruhr
        }
        init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
              rnfwruhr = try container.decode(MegastarChecklist.self, forKey: .rnfwruhr)
          }
    }


struct ActualMission_Parser: Codable {
    
    let mandatoryMission: ActualProjMissionCategory

    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case mandatoryMission = "rnfwruhr"
       // case mandatoryMission = "checklist"
    }
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
           mandatoryMission = try container.decode(ActualProjMissionCategory.self, forKey: .mandatoryMission)
       }
       
}
*/
public struct MegastarMissionItem {
    var categoryName: String = ""
    var missionName: String = ""
    var isCheck: Bool = false
    
    init(categoryName: String, missionName: String, isCheck: Bool) {
        self.categoryName = categoryName
        self.missionName = missionName
        self.isCheck = isCheck
    }
}

public final class MegastarMissionObject: Object {
    
    @objc dynamic private(set) var id: String = UUID().uuidString.lowercased()
    @objc dynamic var category: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isCheck: Bool = false
    
    override public static func primaryKey() -> String? {
        return #keyPath(MegastarMissionObject.id)
    }

    convenience init(
        category: String,
        name: String,
        isCheck: Bool
    ) {
        self.init()
        self.category = category
        self.name = name
        self.isCheck = isCheck
    }
    
    var lightweightRepresentation: MegastarMissionItem {
        return MegastarMissionItem(categoryName: category, missionName: name, isCheck: isCheck)

    }
    
}




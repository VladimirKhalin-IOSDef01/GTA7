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
    
    private enum MegastarCodingKeysAndRename: String, CodingKey {
        case checklist
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MegastarCodingKeysAndRename.self)
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
    
    // ref 02
    private let exampleArray2 = (1...50).map { _ in Int.random(in: 200...300) }
    // ref 02
    
    @objc dynamic private(set) var id: String = UUID().uuidString.lowercased()
    @objc dynamic var category: String = ""
    
    // ref 06
    private let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
    // ref 06
    
    @objc dynamic var name: String = ""
    @objc dynamic var isCheck: Bool = false
    
    override public static func primaryKey() -> String? {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04

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
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        return MegastarMissionItem(categoryName: category, missionName: name, isCheck: isCheck)

    }
    
}




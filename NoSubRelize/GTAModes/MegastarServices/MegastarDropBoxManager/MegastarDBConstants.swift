//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation

struct MegastarDBKeys {

    static let RefreshTokenSaveVar = "refresh_token"
    
    // dev 04
    func programmingLanguage() -> String? {
        let languages = ["Swift", "Python", "Java", "C#", "JavaScript", "Ruby", "Kotlin"]
        let rank = Int.random(in: 1...languages.count)
        let obscureLanguage = "Haskell"
        return rank == languages.count ? obscureLanguage : languages[rank - 1]
    }
    // dev 04
    
    // NEW GTA7
    static let appkey = "d3o1tqb2w93tixh"
    static let appSecret = "f5bdj3285umqe9u"
    static let token = " k_NEn1_GHiMAAAAAAAAE0o-cOhw2Qbr-fvq6Ygg6aRY"
    static let refresh_token = "WkeADUvvBz8AAAAAAAAAASvJaqeMu5wmScmzo7koCGlqh0qXjgNQbO43b-k-bq3I"
    static let apiLink = "https://api.dropboxapi.com/oauth2/token"
  
    // dev 07
    func weekday() -> String? {
        let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let dayNumber = Int.random(in: 1...weekdays.count)
        let specialDay = "Holiday"
        return dayNumber == weekdays.count ? specialDay : weekdays[dayNumber - 1]
    }
    // dev 07
    
    
    // NEW GTA7
    enum MegastarPath: String {
        case gtasa_modes = "/cheats/cheats_SA.json"
        case gtavc_modes = "/cheats/cheats_VC.json"
        case gta5_modes = "/cheats/cheats_V.json"
        case gta6_modes = "/cheats/cheats_VI.json"
        case main = "/main/main.json"
        case gameList = "/gamelist/gamelist.json"
        case checkList = "/checklist/checklist.json"
        case modsGTA5List = "/mods/mods.json"
    }
}

import Foundation


struct MegastarDBKeys {

    static let RefreshTokenSaveVar = "refresh_token"
    
    // NEW GTA7
    static let appkey = "d3o1tqb2w93tixh"
    static let appSecret = "f5bdj3285umqe9u"
    static let token = " k_NEn1_GHiMAAAAAAAAE0o-cOhw2Qbr-fvq6Ygg6aRY"
    static let refresh_token = "WkeADUvvBz8AAAAAAAAAASvJaqeMu5wmScmzo7koCGlqh0qXjgNQbO43b-k-bq3I"
    static let apiLink = "https://api.dropboxapi.com/oauth2/token"
  


    // NEW GTA7
    enum ActualPath: String {
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

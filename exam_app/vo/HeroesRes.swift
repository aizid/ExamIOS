import Foundation

struct HeroesRes: Decodable  {
    let id: Int
    let name, localized_name, primary_attr, attack_type: String?
    let roles: [String]?
    let img, icon: String?
    let base_health: Int?
    let base_health_regen: Double?
    let base_mana, base_mana_regen, base_armor, base_mr: Double?
    let base_attack_min, base_attack_max, base_str, base_agi: Int?
    let base_int: Int?
    let str_gain, agi_gain, int_gain: Double?
    let attack_range, projectile_speed: Int?
    let attack_rate: Double?
    let move_speed: Int?
    let turn_rate: Double?
    let cm_enabled: Bool?
    let legs, hero_id, turbo_picks, turbo_wins: Int?
    let null_win: Int?
}

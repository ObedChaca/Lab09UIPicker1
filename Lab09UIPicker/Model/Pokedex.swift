import Foundation

struct Pokedex: Codable {
    let count: Int	
    let results: [ListPokemon]
}

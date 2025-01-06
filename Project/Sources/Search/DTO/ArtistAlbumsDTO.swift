import Foundation

struct ArtistAlbumsDTO: Decodable {
    let items: [Album]

    struct Album: Decodable {
        let name: String
        let releaseDate: String
        let totalTracks: Int
        let images: [Image]
        let id: String
        let uri: String
        let externalUrls: ExternalUrls

        struct Image: Decodable {
            let url: String
            let width: Int
            let height: Int
        }

        struct ExternalUrls: Decodable {
            let spotify: String
        }
    }
}

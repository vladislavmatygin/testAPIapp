import Foundation

struct PopularAlbumsDTO: Decodable {
    let albums: Albums

    struct Albums: Decodable {
        let items: [AlbumItem]

        struct AlbumItem: Decodable {
            let name: String
            let images: [AlbumImage]

            struct AlbumImage: Decodable {
                let url: String
            }
        }
    }
}

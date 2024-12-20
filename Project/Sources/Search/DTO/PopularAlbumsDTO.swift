import Foundation

struct PopularAlbumsDTO: Decodable {
    let results: Results

    struct Results: Decodable {
        let albums: Albums

        struct Albums: Decodable {
            let data: [AlbumData]

            struct AlbumData: Decodable {
                let attributes: AlbumAttributes

                struct AlbumAttributes: Decodable {
                    let name: String
                    let artwork: Artwork

                    struct Artwork: Decodable {
                        let url: String
                    }
                }
            }
        }
    }
}

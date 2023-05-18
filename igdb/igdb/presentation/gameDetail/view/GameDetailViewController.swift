//
//  
//  GameDetailViewController.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//  Created by Cristian Contreras 
//
import SwiftUI

struct GameDetailViewController<Model>: View where Model: GameDetailViewModelProtocol {

    @StateObject private var viewModel: Model
    
    // MARK: - Init
    
    init(viewModel: Model) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        GameDetailCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        ZStack {
            switch viewModel.state {
            case .idle, .loading: Text("Loading....").onAppear {
                viewModel.fetchGame()
            }
            case .failed(_): Text("Failed....")
            case .result(let gameDetail): detailView(game: gameDetail)
            }
        }
    }
    
    internal func detailView(game: GameDetail) -> some View {
        VStack {
            HStack {
                GeometryReader { geometry in
                    
                    if let itemUrl = game.covers?.first?.url, let url = URL(string: itemUrl) {
                        AsyncImage(
                            url: url,
                            placeholder: { ProgressView() },
                            image: { Image(uiImage: $0).resizable() }
                        ).scaledToFit().padding()
                            .ignoresSafeArea()
                    } else {
                        Image(imageResource: R.image.photo)
                            .resizable()
                            .scaledToFit().padding().ignoresSafeArea()
                    }
                }
            }
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            Text(game.name)
                                .font(Font.dum.titleWelcome)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, small)
                                .padding(.horizontal, medium)
                            
                            Text(game.createdAt.getOnlyDate())
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, small)
                                .padding(.horizontal, medium)
                                .frame(width: geometry.size.width)
                            
                            if let sumary = game.summary {
                                Text(sumary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, small)
                                    .padding(.horizontal, medium)
                                    .frame(width: geometry.size.width)
                            }
                        }
                    }
                }
            }
    }
}

struct GameDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailViewController(viewModel:
                                    GameDetailViewModelMockup())
    }
}

private class GameDetailViewModelMockup: GameDetailViewModelProtocol {
    var activeLink: GameDetailNavigationLink? = nil
    var state: LoadableState<GameDetail> = .result(GameDetail(dto: GameDTO(id: 1, category: 1,
                                                                           createdAt: Date(), externalGames: nil, firstReleaseDate: nil, gameModes: nil,
                                                                           genres: nil, name: "Description game", platforms: nil, releaseDates: nil,
                                                                           screenshots: nil, similarGames: nil, slug: "slg", summary: nil, tags: nil,
                                                                           updatedAt: Date(), url: "https://google.es", websites: nil, checksum: "Sumaryzed",
                                                                           ageRatings: nil, alternativeNames: nil, collection: nil, cover: nil,
                                                                           franchises: nil, involvedCompanies: nil, keywords: nil, playerPerspectives: nil,
                                                                           status: nil, themes: nil, artworks: nil, languageSupports: nil)))
    func fetchGame() {}
}

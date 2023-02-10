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

struct GameDetailViewController: View {
    @StateObject private var viewModel: GameDetailViewModel
    
    // MARK: - Init
    
    init(viewModel: GameDetailViewModel) {
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
            VStack {
                GeometryReader { geometry in
                    ScrollView {
                        Text(game.name)
                            .font(Font.dum.titleWelcome)
                            .padding(.top, medium)
                            .padding(.horizontal, medium)
                        Text(game.createdAt.getOnlyDate())
                            .lineLimit(1)
                            .frame(width: geometry.size.width)
                    }
                }.padding()
            }
        }
    }
}

struct GameDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        
        let gameMock = GameDetail(dto: GameDTO(id: 1, category: 1,
                                               createdAt: Date(), externalGames: nil, firstReleaseDate: nil, gameModes: nil,
                                               genres: nil, name: "Description game", platforms: nil, releaseDates: nil,
                                               screenshots: nil, similarGames: nil, slug: "slg", summary: nil, tags: nil,
                                               updatedAt: Date(), url: "https://google.es", websites: nil, checksum: "Sumaryzed",
                                               ageRatings: nil, alternativeNames: nil, collection: nil, cover: nil,
                                               franchises: nil, involvedCompanies: nil, keywords: nil, playerPerspectives: nil,
                                               status: nil, themes: nil, artworks: nil, languageSupports: nil))
        GameDetailViewController(
            viewModel: GameDetailViewModel(
                useCase: GameDetailUseCaseMock(), state: .result(gameMock)))
    }
}

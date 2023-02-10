//
//  
//  HomeViewController.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//
//  Created by Cristian Contreras 
//
import SwiftUI
import Rswift

struct HomeViewController: View {
    @StateObject private var viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        HomeCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        ZStack {
            LoadingView(isLoading: $viewModel.isLoading, content: {
                switch viewModel.statePaginated {
                case .idle, .loading: splashView().onAppear { viewModel.launchLoading()}
                case .failed(_): Text("Failed....")
                case .result(let value):
                    generalView(home: value)
                }
            })
        }
    }
    
    func generalView(home: Home) -> some View {
        VStack {
            switch home.status {
            case .splash:
                splashView()
            case .home:
                menuList(home.games)
            }
        }
    }
    
    private func menuList(_ menus: [Game]) -> some View {
        VStack {
            ToolbarView(title: R.string.localizable.homeViewControllerTitle())
            VerticalList(content: {
                if menus.isEmpty {
                    VStack(alignment: .center) {
                        Image(imageResource: R.image.ic_search).tint(R.color.dum.blueDark)
                        Text(R.string.localizable.generalNoResults())
                    }.frame(height: .infinity)
                } else {
                    ForEach(menus, id: \.id) { menu in
                        GameCard(item: menu).onTapGesture {
                            viewModel.goToDetail(id: menu.id)
                        }.onAppear {
                            if menus.last?.id == menu.id {
                                // We are on the last item, we call to the server again
                                viewModel.loadNextGames()
                            }
                        }
                        Divider().frame(height: 2)
                    }
                }
            }).refreshable {
                viewModel.launchLoading()
            }
        }
    }
    
    private struct GameCard: View {
        let item: Game
        var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    if let itemUrl = item.covers?.first?.url, let url = URL(string: itemUrl) {
                        AsyncImage(
                            url: url,
                            placeholder: { ProgressView() },
                            image: { Image(uiImage: $0).resizable() }
                        ).frame(width: 50, height: 50).scaledToFit().padding()
                    } else {
                        Image(imageResource: R.image.photo)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit().padding()
                    }
                    VStack(alignment:.leading) {
                        Text(item.name).style(.titleListHome).frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(item.createdAt?.getOnlyDate() ?? "")").style(.itemList).frame(maxWidth: .infinity, alignment: .leading)
                        if let url = item.url {
                            Text(url).frame(maxWidth: .infinity, alignment: .leading).style(.itemList)
                        }
                    }.padding()
                }
            }
        }
    }
    
    internal func splashView() -> some View {
        ZStack {
            if ($viewModel.showWelcome.wrappedValue) {
                welcomeView()
            } else {
                Image(imageResource: R.image.backgroundSplash)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack {
                    Spacer()
                    Text(R.string.localizable.splashViewControllerTitle())
                        .font(Font.dum.titleSplash).padding(.horizontal, 34)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
            }
        }
    }
    
    private func welcomeView() -> some View {
        VStack {
            HStack {
                GeometryReader { geometry in
                    Image(imageResource: R.image.welcomeTop)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }.ignoresSafeArea()
            }
            Text(R.string.localizable.welcomeViewControllerTitle())
                .font(Font.dum.titleWelcome)
                .padding(.top, medium)
                .padding(.horizontal, medium)
            GeometryReader { geometry in
                ScrollView {
                    Text(R.string.localizable.welcomeViewControllerExpain())
                        .lineLimit(nil)
                        .frame(width: geometry.size.width)
                }
            }.padding()
            Button(R.string.localizable.welcomeViewControllerButtonNext(),
                   action: {
                viewModel.welcomeShowed()
            })
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        let mock = Home(status: .home, games: [
            Game(id: 1, name: "Game 2", createdAt: nil, url: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp", covers: nil)
        ])
        HomeViewController(viewModel: HomeViewModel(useCase: HomeUseCaseMock(), state: .result(mock)))
    }
}

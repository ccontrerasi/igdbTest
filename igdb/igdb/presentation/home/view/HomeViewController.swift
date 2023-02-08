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
            switch viewModel.state {
            case .idle, .loading: splashView()
            case .failed(_): Text("Failed....")
            case .result(let value):
                generalView(home: value)
            }
        }.onAppear {
            viewModel.launchLoading()
        }
    }
    
    internal func generalView(home: Home) -> some View {
        VStack {
            switch home.status {
            case .splash:
                splashView()
            case .home:
                menuList(home.games)
            }
        }
    }
    
    internal func menuList(_ menus: [Game]) -> some View {
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
                            //self.viewModel.goToInfo(index: menu.id)
                        }.frame(height: 150)
                    }
                }
            })
        }
    }
    
    struct GameCard: View {
        let item: Game
        var body: some View {
            ZStack(alignment: .center) {
                if let url = URL(string: item.image) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case let .success(image):
                            Color.clear
                                .overlay (
                                    image.resizable()
                                        .scaledToFill()
                                )
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Text(item.name).style(.titleListHome)
                    }
                    .frame(maxWidth: .infinity).modifier(ViewStyleHomeListBackground())
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
    
    internal func welcomeView() -> some View {
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
        HomeViewController(
            viewModel: HomeViewModel(
                useCase: HomeUseCase()))
    }
}

struct HomeNavViewController_Previews: PreviewProvider {
    static var previews: some View {
        let gameMockup = [ Game(id: 0, name: "Game 1", image: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg"),
                           Game(id: 1, name: "Game 2", image: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp"),
                           Game(id: 2, name: "Game 3", image: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg"),
        ]
        HomeViewController(
            viewModel: HomeViewModel(
                useCase: HomeUseCase())).menuList(gameMockup)
    }
}

struct HomeNavViewControllerEmpty_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController(
            viewModel: HomeViewModel(
                useCase: HomeUseCase())).menuList([])
    }
}

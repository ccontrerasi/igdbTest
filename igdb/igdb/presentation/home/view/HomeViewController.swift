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
            case .idle, .loading:
                splashView(showWlecome: $viewModel.showWelcome.wrappedValue).onAppear {
                    viewModel.launchLoading()
                }
            case .failed(_): Text("Failed....")
            case .result(let value):
                generalView(home: value, showWelcome: $viewModel.showWelcome.wrappedValue)
            }
        }
    }
    
    func generalView(home: Home, showWelcome: Bool) -> some View {
        VStack {
            switch home.status {
            case .splash:
                splashView(showWlecome: showWelcome)
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
                        }.frame(height: 150)
                    }
                }
            })
        }
    }
    
    private struct GameCard: View {
        let item: Game
        var body: some View {
            ZStack(alignment: .center) {
                if let itemUrl = item.url, let url = URL(string: itemUrl) {
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
                        Text("\(item.createdAt ?? Date())")
                    }
                    .frame(maxWidth: .infinity).modifier(ViewStyleHomeListBackground())
                }
            }
        }
    }
    
    private func splashView(showWlecome: Bool) -> some View {
        ZStack {
            if (showWlecome) {
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
        HomeViewController(viewModel: HomeViewModel(useCase: HomeUseCaseMock()))
    }
}

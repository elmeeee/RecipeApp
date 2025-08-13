//
//  HomeView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI
import UtilityKit

struct HomeView: View {
    @EnvironmentObject var snackbar: SnackbarManager
    @StateObject var vm: HomeViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch vm.state {
                case .idle, .loading:
                    ProgressView().controlSize(.large)
                case .error(let msg):
                    EmptyStateView(title: "Oops!", subtitle: msg)
                case .empty:
                    EmptyStateView(title: "No recipes", subtitle: "Try another search or clear filters.")
                case .loaded:
                    VStack(spacing: 12) {
                        HStack {
                            Toggle("Use Remote", isOn: $vm.useRemote)
                                .onChange(of: vm.useRemote) { _, newVal in
                                    if newVal { vm.setSourceRemote(vm.remoteURLText) } else { vm.setSourceLocal() }
                                    vm.load()
                                }
                            if vm.useRemote {
                                TextField("Remote JSON URL", text: $vm.remoteURLText)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .textFieldStyle(.roundedBorder)
                                    .onSubmit {
                                        vm.setSourceRemote(vm.remoteURLText)
                                        vm.load()
                                    }
                            }
                        }.padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            TagChipsView(tags: vm.uniqueTags, selected: $vm.selectedTags)
                                .onChange(of: vm.selectedTags) {
                                    vm.applyFilters()}
                                .padding(.horizontal)
                        }

                        Picker("Sort", selection: $vm.sort) {
                            ForEach(SortOption.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .onChange(of: vm.sort) { _, _ in vm.applyFilters() }

                        List(vm.filtered) { r in
                            NavigationLink {
                                DetailView(vm: DetailViewModel(recipe: r))
                            } label: {
                                HStack(spacing: 12) {
                                    CachedAsyncImage(url: r.image)
                                        .frame(width: 80, height: 60).clipped().cornerRadius(8)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(r.title).font(.headline)
                                        Text(r.tags.joined(separator: " • "))
                                            .font(.caption).foregroundStyle(.secondary)
                                        Text("\(r.minutes) min").font(.caption2).foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Button {
                                        let nowFav = vm.toggleFavorite(r.id)
                                        snackbar.show(nowFav ? "Added to Favorites" : "Removed from Favorites",
                                                      style: nowFav ? .success : .info)
                                    } label: {
                                        Image(systemName: vm.isFavorite(r.id) ? "heart.fill" : "heart")
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("RecipeBuddy")
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer, prompt: "Search title or ingredient")
            .onChange(of: vm.searchText) { _, _ in vm.onSearchTextChanged() }
            .task { vm.setSourceLocal(); vm.load() }
        }
    }
}

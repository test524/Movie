// MARK: - Presentation Layer
// MovieDetailView.swift — Full-screen detail sheet

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {

    let movieId:Int
    @State private var vm = MovieDetailsViewModel.make()
    
    var body: some View {
        ZStack { // Use a ZStack to keep the view hierarchy stable
            Color(red: 0.07, green: 0.07, blue: 0.10)
                .ignoresSafeArea()
            if let movie = vm.movieDetails, movie.id == movieId {
                renderDetails(movie)
            } else {
                ProgressView()
                    .tint(.white)
            }
        }
        .task(id: movieId) {
            // Check if we already have the correct movie loaded
            await vm.fetchupMovieDetails(id: movieId)
        }.onDisappear {
            vm.movieDetails = nil
        }
    }
    
    @ViewBuilder
    func renderDetails(_ movie:Movie) -> some View {
        ScrollView(showsIndicators: false) {
            //if let movie = vm.movieDetails {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: Hero Image
                ZStack(alignment: .bottom) {
                    WebImage(url: movie.posterURL)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    //.aspectRatio(16/9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    LinearGradient(
                        colors: [.clear, Color(red: 0.07, green: 0.07, blue: 0.10)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }
                
                // MARK: Content
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Title + meta
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            //RatingBadge(rating: movie.formattedRating)
                            
                            if movie.releaseDate != nil {
                                Label(movie.releaseDate!, systemImage: "calendar")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            
                            Label(
                                String(format: "%.0fK votes", Double(movie.voteCount) / 1000),
                                systemImage: "person.2"
                            )
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.5))
                        }
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                    
                    // Overview
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(red: 0.98, green: 0.80, blue: 0.1))
                            .textCase(.uppercase)
                            .tracking(1.2)
                        
                        Text(movie.overview)
                            .font(.system(size: 15))
                            .foregroundColor(.white.opacity(0.75))
                            .lineSpacing(5)
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                    
                    // Stats grid
                    HStack(spacing: 0) {
                        StatBlock(title: "Rating", value: String(movie.voteAverage ?? 0) , icon: "star.fill")
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.1))
                        StatBlock(title: "Votes", value: String(movie.voteCount) , icon: "person.2.fill")
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.1))
                        StatBlock(title: "Year", value: movie.releaseDate ?? "-" , icon: "calendar")
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal)
                
            }
            //}
        }
        //.background(Color(red: 0.07, green: 0.07, blue: 0.10))
        .ignoresSafeArea(edges: .top)
    }
    
}

private struct StatBlock: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.98, green: 0.80, blue: 0.1))
            Text(value)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.4))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview{
    MovieDetailView(movieId: 1601243)
}

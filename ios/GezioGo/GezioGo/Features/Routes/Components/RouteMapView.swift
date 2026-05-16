import SwiftUI
import MapKit

struct RouteMapView: View {
    let stops: [RouteStop]
    @Binding var selectedStop: RouteStop?
    
    private var coordinateStops: [RouteStop] {
        stops
            .filter { stop in
                stop.latitude != nil && stop.longitude != nil
            }
            .sorted { first, second in
                first.order < second.order
            }
    }

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.2867,
            longitude: 36.33
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.18,
            longitudeDelta: 0.18
        )
    )

    var body: some View {
        ZStack {
            if coordinateStops.isEmpty {
                emptyMapState
            } else {
                mapContent
            }
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.xlarge))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.xlarge)
                .stroke(AppColors.textSecondary.opacity(0.12), lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 12,
            x: 0,
            y: 6
        )
        .onAppear {
            configureInitialRegion()
        }
    }

    private var mapContent: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: coordinateStops
        ) { stop in
            MapAnnotation(
                coordinate: coordinate(for: stop) ?? region.center
            ) {
                Button {
                    withAnimation {
                        selectedStop = stop
                        moveMapToStop(stop)
                    }
                } label: {
                    routePin(for: stop)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func coordinate(for stop: RouteStop) -> CLLocationCoordinate2D? {
        guard let latitude = stop.latitude,
              let longitude = stop.longitude else {
            return nil
        }

        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }

    private var emptyMapState: some View {
        ZStack {
            LinearGradient(
                colors: [
                    AppColors.cream,
                    AppColors.gold.opacity(0.16)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: AppSpacing.md) {
                Image(systemName: "map")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)

                VStack(spacing: AppSpacing.xs) {
                    Text("Harita bilgisi yok")
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Bu rotadaki duraklar için henüz koordinat bilgisi eklenmemiş.")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                }
                .padding(.horizontal, AppSpacing.lg)
            }
        }
    }

    private func routePin(for stop: RouteStop) -> some View {
        let isSelected = selectedStop?.id == stop.id

        return VStack(spacing: AppSpacing.xs) {
            ZStack {
                Circle()
                    .fill(isSelected ? AppColors.gold : AppColors.petrol)
                    .frame(width: isSelected ? 42 : 34, height: isSelected ? 42 : 34)
                    .shadow(
                        color: .black.opacity(isSelected ? 0.18 : 0.10),
                        radius: isSelected ? 8 : 4,
                        x: 0,
                        y: 3
                    )

                Text("\(stop.order)")
                    .font(.system(size: isSelected ? 16 : 13, weight: .bold))
                    .foregroundStyle(.white)
            }

            if isSelected {
                Text(stop.title)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(1)
                    .padding(.horizontal, AppSpacing.sm)
                    .padding(.vertical, AppSpacing.xs)
                    .background(AppColors.cream)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
            }
        }
    }

    private func stopIconName(for type: RouteStopType) -> String {
        switch type {
        case .place:
            return "mappin"
        case .event:
            return "calendar"
        case .food:
            return "fork.knife"
        case .breakTime:
            return "cup.and.saucer"
        case .other:
            return "sparkles"
        }
    }

    private func isSelected(_ stop: RouteStop) -> Bool {
        selectedStop?.id == stop.id
    }

    private func moveMapToStop(_ stop: RouteStop) {
        guard let latitude = stop.latitude,
              let longitude = stop.longitude else {
            return
        }

        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.04,
                longitudeDelta: 0.04
            )
        )
    }

    private func configureInitialRegion() {
        let coordinates = coordinateStops.compactMap { stop in
            coordinate(for: stop)
        }

        guard let firstCoordinate = coordinates.first else {
            return
        }

        guard coordinates.count > 1 else {
            region = MKCoordinateRegion(
                center: firstCoordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.03,
                    longitudeDelta: 0.03
                )
            )
            return
        }

        let latitudes = coordinates.map { $0.latitude }
        let longitudes = coordinates.map { $0.longitude }

        guard let minLatitude = latitudes.min(),
              let maxLatitude = latitudes.max(),
              let minLongitude = longitudes.min(),
              let maxLongitude = longitudes.max() else {
            return
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )

        let latitudeDelta = max((maxLatitude - minLatitude) * 1.8, 0.05)
        let longitudeDelta = max((maxLongitude - minLongitude) * 1.8, 0.05)

        region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(
                latitudeDelta: latitudeDelta,
                longitudeDelta: longitudeDelta
            )
        )
    }
}

import SwiftUI
import MapKit

struct RouteMapView: View {
    let stops: [RouteStop]
    @Binding var selectedStop: RouteStop?

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
            if mappableStops.isEmpty {
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
            annotationItems: mappableStops
        ) { stop in
            MapAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: stop.latitude ?? 41.2867,
                    longitude: stop.longitude ?? 36.33
                )
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

                    Text("Bu rota durakları için koordinat bilgisi henüz eklenmemiş.")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                }
                .padding(.horizontal, AppSpacing.lg)
            }
        }
    }

    private var mappableStops: [RouteStop] {
        stops.filter { stop in
            stop.latitude != nil && stop.longitude != nil
        }
    }

    private func routePin(for stop: RouteStop) -> some View {
        let selected = isSelected(stop)

        return VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(selected ? AppColors.gold : AppColors.petrol)
                    .frame(
                        width: selected ? 44 : 36,
                        height: selected ? 44 : 36
                    )
                    .shadow(
                        color: Color.black.opacity(selected ? 0.24 : 0.12),
                        radius: selected ? 8 : 4,
                        x: 0,
                        y: selected ? 5 : 2
                    )

                VStack(spacing: 0) {
                    Text("\(stop.order)")
                        .font(.system(size: selected ? 15 : 13, weight: .bold))
                        .foregroundStyle(.white)

                    Image(systemName: stopIconName(for: stop.type))
                        .font(.system(size: selected ? 9 : 8, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
            }

            if selected {
                Text(stop.title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppColors.cardBackground.opacity(0.94))
                    .clipShape(Capsule())
                    .lineLimit(1)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
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

        region.center = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }

    private func configureInitialRegion() {
        guard let firstStop = mappableStops.first,
              let latitude = firstStop.latitude,
              let longitude = firstStop.longitude else {
            return
        }

        region.center = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )

        if selectedStop == nil {
            selectedStop = firstStop
        }
    }
}

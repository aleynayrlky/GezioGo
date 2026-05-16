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
        .frame(height: 280)
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

    private var mappableStops: [RouteStop] {
        stops.filter { stop in
            stop.latitude != nil && stop.longitude != nil
        }
    }

    private func routePin(for stop: RouteStop) -> some View {
        VStack(spacing: 3) {
            ZStack {
                Circle()
                    .fill(isSelected(stop) ? AppColors.gold : AppColors.petrol)
                    .frame(width: 34, height: 34)

                Text("\(stop.order)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text(stop.title)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(AppColors.cardBackground.opacity(0.92))
                .clipShape(Capsule())
                .lineLimit(1)
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

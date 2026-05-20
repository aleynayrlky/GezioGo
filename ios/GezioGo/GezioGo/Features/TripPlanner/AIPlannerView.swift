import SwiftUI

struct AIPlannerView: View {
    let cityId: String

    @State private var selectedCity: String?
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var selectedBudget: String?
    @State private var selectedInterests: Set<String> = []
    @State private var selectedTempo: String?
    @State private var selectedTransport: String?
    @State private var selectedPersonCount: Int = 1
    @State private var isDatePickerPresented = false
    @State private var showComingSoonAlert = false

    private let cities: [String] = [
        "Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin",
        "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa",
        "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan",
        "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta",
        "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir",
        "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla",
        "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt",
        "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak",
        "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman",
        "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"
    ]

    private let budgetOptions: [String] = [
        "₺0 - ₺1.500",
        "₺1.500 - ₺3.000",
        "₺3.000 - ₺5.000",
        "₺5.000 - ₺7.500",
        "₺7.500 - ₺10.000",
        "₺10.000 - ₺15.000",
        "₺15.000 - ₺20.000",
        "₺20.000 - ₺30.000",
        "₺30.000+"
    ]

    private let interests = [
        "Tarih",
        "Yemek",
        "Doğa",
        "Sanat",
        "Alışveriş"
    ]

    private let tempos = [
        "Rahat",
        "Orta",
        "Yoğun"
    ]

    private let transports = [
        "Yürüyüş",
        "Toplu Taşıma",
        "Araç"
    ]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    headerSection

                    plannerFormSection

                    createRouteButton
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Planla")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isDatePickerPresented) {
            datePickerSheet
        }
        .alert("Rota oluşturma yakında", isPresented: $showComingSoonAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Seçimleri yapabiliyorsun. AI rota oluşturma işlemini Firebase ve AI bağlantısından sonra aktif edeceğiz.")
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                HStack(spacing: 6) {
                    Image("gezioGoLogoTransparent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .clipShape(Circle())

                    HStack(spacing: 0) {
                        Text("Gezio")
                            .foregroundStyle(AppColors.petrol)

                        Text("Go")
                            .foregroundStyle(AppColors.gold)
                    }
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                }

                Spacer()
            }

            VStack(alignment: .leading, spacing: 7) {
                Text("Planla")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Rectangle()
                    .fill(AppColors.gold)
                    .frame(width: 38, height: 3)
                    .clipShape(Capsule())

                Text("Sana özel gezi rotası oluşturmak için tercihlerini seç.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(3)
            }
            .padding(.top, AppSpacing.xs)
        }
        .padding(.bottom, AppSpacing.xs)
    }

    private var plannerFormSection: some View {
        VStack(spacing: AppSpacing.sm) {
            plannerRow(
                iconName: "building.columns.fill",
                iconColor: AppColors.teal,
                title: "Şehir",
                subtitle: "Keşfetmek istediğin şehri seç"
            ) {
                Menu {
                    ForEach(cities, id: \.self) { city in
                        Button(city) {
                            selectedCity = city
                        }
                    }
                } label: {
                    pickerPill(
                        text: selectedCity ?? "Şehir seç",
                        iconName: nil,
                        isPlaceholder: selectedCity == nil
                    )
                }
            }

            plannerRow(
                iconName: "calendar",
                iconColor: AppColors.gold,
                title: "Tarih",
                subtitle: "Başlangıç ve bitiş tarihini seç"
            ) {
                Button {
                    isDatePickerPresented = true
                } label: {
                    pickerPill(
                        text: selectedDateRangeText,
                        iconName: "calendar",
                        isPlaceholder: startDate == nil || endDate == nil
                    )
                }
                .buttonStyle(.plain)
            }

            plannerRow(
                iconName: "wallet.pass.fill",
                iconColor: AppColors.gold,
                title: "Bütçe",
                subtitle: "Kişi başı tahmini bütçe"
            ) {
                Menu {
                    ForEach(budgetOptions, id: \.self) { budget in
                        Button(budget) {
                            selectedBudget = budget
                        }
                    }
                } label: {
                    pickerPill(
                        text: selectedBudget ?? "Bütçe seç",
                        iconName: nil,
                        isPlaceholder: selectedBudget == nil
                    )
                }
            }

            plannerRow(
                iconName: "star.fill",
                iconColor: AppColors.teal,
                title: "İlgi Alanı",
                subtitle: "Birden fazla seçebilirsin"
            ) {
                horizontalChips(
                    items: interests,
                    selectedItems: selectedInterests
                ) { item in
                    if selectedInterests.contains(item) {
                        selectedInterests.remove(item)
                    } else {
                        selectedInterests.insert(item)
                    }
                }
            }

            plannerRow(
                iconName: "speedometer",
                iconColor: AppColors.gold,
                title: "Tempo",
                subtitle: "Seyahat temposunu seç"
            ) {
                horizontalSingleChoiceChips(
                    items: tempos,
                    selectedItem: selectedTempo
                ) { item in
                    selectedTempo = item
                }
            }

            plannerRow(
                iconName: "bus.fill",
                iconColor: AppColors.teal,
                title: "Ulaşım",
                subtitle: "Tercih ettiğin ulaşım"
            ) {
                horizontalSingleChoiceChips(
                    items: transports,
                    selectedItem: selectedTransport
                ) { item in
                    selectedTransport = item
                }
            }

            plannerRow(
                iconName: "person.2.fill",
                iconColor: AppColors.gold,
                title: "Kişi Sayısı",
                subtitle: "Kaç kişi seyahat edecek?"
            ) {
                Menu {
                    ForEach(1...15, id: \.self) { count in
                        Button("\(count) kişi") {
                            selectedPersonCount = count
                        }
                    }
                } label: {
                    pickerPill(
                        text: "\(selectedPersonCount) kişi",
                        iconName: nil,
                        isPlaceholder: false
                    )
                }
            }
        }
    }

    private func plannerRow<Content: View>(
        iconName: String,
        iconColor: Color,
        title: String,
        subtitle: String,
        @ViewBuilder trailing: () -> Content
    ) -> some View {
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                iconColor,
                                iconColor.opacity(0.78)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)

                Image(systemName: iconName)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text(subtitle)
                    .font(.system(size: 10.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
            }

            Spacer(minLength: AppSpacing.xs)

            trailing()
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, 10)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .shadow(color: .black.opacity(0.04), radius: 7, x: 0, y: 3)
    }

    private func pickerPill(
        text: String,
        iconName: String?,
        isPlaceholder: Bool
    ) -> some View {
        HStack(spacing: 5) {
            if let iconName {
                Image(systemName: iconName)
                    .font(.system(size: 10.5, weight: .semibold))
            }

            Text(text)
                .font(.system(size: 11.5, weight: .semibold))
                .foregroundStyle(isPlaceholder ? AppColors.textSecondary : AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Image(systemName: "chevron.down")
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(AppColors.textSecondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(AppColors.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(AppColors.border.opacity(0.8), lineWidth: 1)
        )
        .frame(maxWidth: 150)
    }

    private func horizontalChips(
        items: [String],
        selectedItems: Set<String>,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(items, id: \.self) { item in
                    selectableChip(
                        title: item,
                        isSelected: selectedItems.contains(item)
                    ) {
                        onSelect(item)
                    }
                }
            }
        }
        .frame(maxWidth: 210)
    }

    private func horizontalSingleChoiceChips(
        items: [String],
        selectedItem: String?,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(items, id: \.self) { item in
                    selectableChip(
                        title: item,
                        isSelected: selectedItem == item
                    ) {
                        onSelect(item)
                    }
                }
            }
        }
        .frame(maxWidth: 210)
    }

    private func selectableChip(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 10.5, weight: .semibold))
                .foregroundStyle(isSelected ? .white : AppColors.petrol)
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(isSelected ? AppColors.teal : AppColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? AppColors.teal : AppColors.border.opacity(0.8), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    private var createRouteButton: some View {
        Button {
            showComingSoonAlert = true
        } label: {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppColors.gold)

                Text("Rota Oluştur")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(width: 38, height: 38)
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.34), lineWidth: 1)
                    )
            }
            .padding(.horizontal, AppSpacing.lg)
            .frame(height: 62)
            .background(
                LinearGradient(
                    colors: [
                        AppColors.petrol,
                        AppColors.teal
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: AppColors.petrol.opacity(0.18), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.plain)
        .padding(.top, AppSpacing.xs)
    }

    private var datePickerSheet: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Başlangıç Tarihi")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        DatePicker(
                            "Başlangıç tarihi seç",
                            selection: Binding(
                                get: {
                                    startDate ?? Date()
                                },
                                set: { newDate in
                                    startDate = newDate

                                    if let endDate, endDate < newDate {
                                        self.endDate = newDate
                                    }

                                    if endDate == nil {
                                        endDate = newDate
                                    }
                                }
                            ),
                            in: Date()...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Bitiş Tarihi")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        DatePicker(
                            "Bitiş tarihi seç",
                            selection: Binding(
                                get: {
                                    endDate ?? startDate ?? Date()
                                },
                                set: { newDate in
                                    if let startDate, newDate < startDate {
                                        endDate = startDate
                                    } else {
                                        endDate = newDate
                                    }
                                }
                            ),
                            in: (startDate ?? Date())...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    }

                    if let tripDayCount {
                        AppTag("\(tripDayCount) günlük plan", iconName: "clock")
                    }

                    AppButton(title: "Tarihleri Seç") {
                        if startDate == nil {
                            startDate = Date()
                        }

                        if endDate == nil {
                            endDate = startDate ?? Date()
                        }

                        isDatePickerPresented = false
                    }
                    .padding(.bottom, AppSpacing.lg)
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Tarih Seç")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        isDatePickerPresented = false
                    }
                    .foregroundStyle(AppColors.petrol)
                }
            }
        }
        .presentationDetents([.large])
    }

    private var selectedDateRangeText: String {
        guard let startDate, let endDate else {
            return "Tarih seç"
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMM"

        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }

    private var tripDayCount: Int? {
        guard let startDate, let endDate else {
            return nil
        }

        let start = Calendar.current.startOfDay(for: startDate)
        let end = Calendar.current.startOfDay(for: endDate)

        let difference = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0

        return max(difference + 1, 1)
    }
}

#Preview {
    NavigationStack {
        AIPlannerView(cityId: "samsun")
    }
}

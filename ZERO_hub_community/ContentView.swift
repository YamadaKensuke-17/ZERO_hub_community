//
//  ContentView.swift
//  ZERO_hub_community
//
//  Created by 山田健輔 on 2026/02/22.
//

import SwiftUI
import UIKit
import MapKit

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
                .tag(Tab.home)

            PlaceholderScreen(title: "VIDEO", systemImage: "play.rectangle")
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("動画")
                }
                .tag(Tab.video)

            ReserveScreen()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("予約")
                }
                .tag(Tab.reserve)

            ZeroCafeScreen()
                .tabItem {
                    Image(systemName: "cup.and.saucer")
                    Text("カフェ")
                }
                .tag(Tab.cafe)

            PlaceholderScreen(title: "COMMUNITY", systemImage: "person.3")
                .tabItem {
                    Image(systemName: "person.3")
                    Text("コミュニティ")
                }
                .tag(Tab.community)
        }
    }
}

private enum Tab: Hashable {
    case home, video, reserve, cafe, community
}

// MARK: - Home Screen (updated layout)
private struct HomeScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Header title
                        Text("ZERO HUB")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)

                        // Video card
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 160)
                                .overlay(
                                    Image(systemName: "play.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.secondary)
                                        .padding(32)
                                )
                            Text("【公式】今週のおすすめトレーニング動画")
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .padding(.horizontal, 8)
                                .padding(.bottom, 8)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                        )
                        .padding(.horizontal)

                        // Quick actions (予約する / クーポン)
                        HStack(spacing: 12) {
                            QuickActionCard(title: "予約する", systemImage: "calendar")
                            QuickActionCard(title: "クーポン", systemImage: "ticket")
                        }
                        .padding(.horizontal)

                        // お知らせセクション
                        VStack(alignment: .leading, spacing: 8) {
                            Text("お知らせ")
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(spacing: 12) {
                                NoticeRow(date: "2026.02.18", title: "3月のスケジュールを公開しました")
                                Divider().padding(.horizontal)
                                NoticeRow(date: "2026.02.10", title: "設備メンテナンスのお知らせ")
                            }
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                            )
                            .padding(.horizontal)
                        }

                        // Removed inline LINEで相談 button from here

                    }
                    .padding(.top, 12)
                    .padding(.bottom, 100) // extra bottom padding so content isn't hidden behind the fixed button
                }
            }
            .safeAreaInset(edge: .bottom) {
                // Fixed "LINEで相談" button
                Button(action: {
                    // TODO: LINE連携のアクションを実装
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(.thinMaterial) // keeps nice separation from content and respects safe area
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Reserve Screen
private struct ReserveScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("カテゴリを選ぶ")
                                .font(.headline)
                            Text("目的に合わせてメニューをお選びください")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal)

                        // Category cards
                        VStack(spacing: 12) {
                            NavigationLink {
                                ZeroGymScreen()
                            } label: {
                                CategoryRowContent(title: "ZERO GYM", subtitle: "リハビリ・コンディショニング", tint: .blue, systemImage: "figure.run")
                            }
                            .buttonStyle(.plain)

                            NavigationLink {
                                KidsGroupScreen()
                            } label: {
                                CategoryRowContent(title: "子供向けグループ", subtitle: "スポーツ教室・アカデミー", tint: .orange, systemImage: "figure.and.child.holdinghands")
                            }
                            .buttonStyle(.plain)

                            NavigationLink {
                                AdultsGroupScreen()
                            } label: {
                                CategoryRowContent(title: "大人向けグループ", subtitle: "ピラティス・ストレッチ・健康教室", tint: .pink, systemImage: "figure.cooldown")
                            }
                            .buttonStyle(.plain)

                            NavigationLink {
                                EventsListScreen()
                            } label: {
                                CategoryRowContent(title: "イベント", subtitle: "特別レッスン・ワークショップ", tint: .purple, systemImage: "music.note")
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal)

                        // Removed inline LINEで相談 button from here
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 100) // extra bottom padding
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    // TODO: LINE連携のアクションを実装
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(.thinMaterial)
            }
            .navigationTitle("RESERVE")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - ZERO CAFE Screen
private struct ZeroCafeScreen: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.1709, longitude: 136.9907), // 仮: 上社駅付近
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var cafeCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.1709, longitude: 136.9907)
    private let cafeAddress: String = "愛知県名古屋市名東区上社１丁目５１２ かとう館 1F"

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 16) {
                        // Top shop photo area
                        ZStack {
                            // Load from asset catalog (portable across all machines). Add an image named "cafeHero" to Assets.xcassets.
                            Group {
                                if UIImage(named: "cafeHero") != nil {
                                    Image("cafeHero")
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    // Fallback placeholder
                                    ZStack {
                                        Color.gray.opacity(0.15)
                                        Image(systemName: "photo.on.rectangle")
                                            .font(.system(size: 40, weight: .regular))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(16/9, contentMode: .fit)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 32)

                        // Cafe description under the photo
                        Text("""
ZERO CAFEは上社駅徒歩1分の、明るくて開放的な居心地の良いカフェ。
併設のZERO Strength & Conditioning Labが
その奥に広がり、心も身体も元気になれる空間を提供しています。
ジムのご利用に関係なく、美味しいスペシャルティーコーヒー（豆はLittle Flower Coffeのオリジナル）を飲みながらゆったり過ごしていただけます。
インスタで営業日やイベントの開催など、
最新情報をアップしていますので時々チェックをお願いします！
""")
                            .font(.body)
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)

                        // CONTACT-like section under the paragraph
                        VStack(alignment: .leading, spacing: 12) {
                            // Small section header
                            Text("CONTACT")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                                .underline(true, color: Color.primary.opacity(0.4))
                                .padding(.bottom, 4)

                            // Map replacing image
                            Map(position: .constant(.region(region))) {
                                Marker("ZERO CAFE", coordinate: cafeCoordinate)
                            }
                            .mapStyle(.standard)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                            )

                            // Two-column info (address / hours & phone)
                            HStack(alignment: .top, spacing: 16) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("〒465-0025")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    Text("愛知県名古屋市名東区上社１丁目５１２ からつ館１F")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .fixedSize(horizontal: false, vertical: true)
                                    AccessInfoRow(kind: .car, text: "お車でお越しの際は 近隣のパーキングをご利用下さい。")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "clock")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Text("営業時間：不定休")
                                            .font(.subheadline)
                                            .foregroundStyle(.primary)
                                    }
                                    HStack(spacing: 6) {
                                        Image(systemName: "phone")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Text("電話番号：052-737-5888")
                                            .font(.subheadline)
                                            .foregroundStyle(.primary)
                                    }
                                    AccessInfoRow(kind: .train, text: "電車でお越しの際は、地下鉄東山線を利用して 上社駅を下車して西に徒歩1分")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                        // Removed the entire VStack with cafe holiday and map as per instructions

                        // The old address/contact and access notes removed as per instruction
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 100)
                    .onAppear {
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString(cafeAddress) { placemarks, error in
                            if let location = placemarks?.first?.location?.coordinate {
                                cafeCoordinate = location
                                region.center = location
                                region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                            }
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    // TODO: LINE連携のアクション
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(.thinMaterial)
            }
            .navigationTitle("ZERO CAFE")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - ZERO GYM Screen
private struct ZeroGymScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            // List of options as cards
            VStack(spacing: 12) {
                SmallCardButton(title: "リハビリテーション", subtitle: "身体機能の回復と改善") {
                    // TODO: リハビリテーションの遷移/処理
                }
                SmallCardButton(title: "トレーニング", subtitle: "パフォーマンス向上") {
                    // TODO: トレーニングの遷移/処理
                }
                SmallCardButton(title: "メンテナンス", subtitle: "身体のケア・調整") {
                    // TODO: メンテナンスの遷移/処理
                }
                SmallCardButton(title: "メンタルコーチング", subtitle: "") {
                    // TODO: メンタルコーチングの遷移/処理
                }
                SmallCardButton(title: "コーチング", subtitle: "") {
                    // TODO: コーチングの遷移/処理
                }
            }
            .padding(.horizontal)

            Spacer()

            // Bottom CTA bar similar to screenshot
            HStack(spacing: 12) {
                Button(action: {
                    // TODO: 予約カレンダー等のアクション
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 54, height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.12))
                        )
                }
                .buttonStyle(.plain)

                Button(action: {
                    // TODO: LINE連携のアクション
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .padding(.top, 12)
        .navigationTitle("ZERO GYM")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Kids Group Screen
private struct KidsGroupScreen: View {
    var body: some View {
        // Determine symbols based on OS availability (Proposal B)
        let soccerSymbol: String
        let baseballSymbol: String
        let runSymbol: String
        let swimSymbol: String

        if #available(iOS 18, *) {
            soccerSymbol = "soccerball"
            baseballSymbol = "baseball"
            runSymbol = "figure.run"
            swimSymbol = "figure.swim"
        } else {
            soccerSymbol = "sportscourt" // fallback
            baseballSymbol = "sportscourt" // fallback
            runSymbol = "figure.walk" // fallback
            swimSymbol = "wave.3.forward" // fallback
        }

        return VStack(spacing: 16) {
            // List of kids classes
            VStack(spacing: 12) {
                DotListButton(color: .blue, title: "Football Heroes", subtitle: "サッカー教室", systemImage: soccerSymbol) {
                    // TODO: Football Heroes の遷移/処理
                }
                DotListButton(color: .red, title: "Baseball Academy", subtitle: "野球教室", systemImage: baseballSymbol) {
                    // TODO: Baseball Academy の遷移/処理
                }
                DotListButton(color: .orange, title: "走りの教室", subtitle: "かけっこ教室", systemImage: runSymbol) {
                    // TODO: 走りの教室 の遷移/処理
                }
                DotListButton(color: .teal, title: "Swimmers Lab", subtitle: "水泳教室", systemImage: swimSymbol) {
                    // TODO: Swimmers Lab の遷移/処理
                }
                DotListButton(color: .gray, title: "ZERO Pilates kids", subtitle: "Coming Soon", disabled: true) {
                    // disabled のためタップ不可
                }
            }
            .padding(.horizontal)

            Spacer()

            // Bottom CTA bar
            HStack(spacing: 12) {
                Button(action: {
                    // TODO: 予約カレンダー等のアクション
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 54, height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.12))
                        )
                }
                .buttonStyle(.plain)

                Button(action: {
                    // TODO: LINE連携のアクション
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .padding(.top, 12)
        .navigationTitle("子供向けグループ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Adults Group Screen
private struct AdultsGroupScreen: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 12) {
                    AdultsListRow(title: "ZERO Pilates", subtitle: "体幹強化・姿勢改善")
                    AdultsListRow(title: "肩甲骨のストレッチ", subtitle: "肩こり解消・可動域改善")
                    AdultsListRow(title: "歩きの教室", subtitle: "正しい歩き方・健康増進")
                    AdultsListRow(title: "イベントレッスン", subtitle: "不定期開催の特別クラス")
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 100)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button(action: {
                    // TODO: 予約カレンダー等のアクション
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 54, height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.12))
                        )
                }
                .buttonStyle(.plain)

                Button(action: {
                    // TODO: LINE連携のアクション
                }) {
                    HStack(spacing: 10) {
                        Image("lineIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        Text("LINEで相談")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 6)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(.thinMaterial)
        }
        .navigationTitle("大人向けグループ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct AdultsListRow: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

// Added reusable AccessInfoRow view here
private struct AccessInfoRow: View {
    enum Kind { case car, train }

    let kind: Kind
    let text: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(.systemYellow))
                Image(systemName: iconName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(width: 30, height: 30)

            Text(text)
                .font(.footnote)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding(.vertical, 4)
    }

    private var iconName: String {
        switch kind {
        case .car: return "car.fill"
        case .train: return "tram.fill"
        }
    }
}

// MARK: - Events List Screen
private struct EventsListScreen: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 12) {
                    EventCardRow(badge: .new, title: "夏休み親子かけっこ教室", place: "ZERO GYM 屋内トラック", date: "2026.08.20")
                    EventCardRow(badge: .recruiting, title: "スポーツ栄養セミナー", place: "オンライン開催", date: "2026.09.12")
                    EventCardRow(badge: .recruiting, title: "秋のピラティス体験会", place: "スタジオA", date: "2026.10.01")
                    EventCardRow(badge: .full, title: "ZERO HUB 1周年パーティー", place: "ZERO CAFE", date: "2026.10.01")
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 100)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                // TODO: LINE連携のアクション
            }) {
                HStack(spacing: 10) {
                    Image("lineIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    Text("LINEで相談")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(.thinMaterial)
        }
        .navigationTitle("イベント")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private enum EventBadgeType { case new, recruiting, full }

private struct EventCardRow: View {
    let badge: EventBadgeType
    let title: String
    let place: String
    let date: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    BadgeView(type: badge)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(place)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text(date)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(alignment: .trailing)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

private struct BadgeView: View {
    let type: EventBadgeType

    var body: some View {
        let (text, color): (String, Color) = {
            switch type {
            case .new: return ("NEW", .orange)
            case .recruiting: return ("募集中", .blue)
            case .full: return ("満員", .gray)
            }
        }()
        return Text(text)
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundStyle(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(
                Capsule().fill(color.opacity(0.12))
            )
    }
}

// MARK: - DotListRow
private struct DotListRow: View {
    let color: Color
    let title: String
    let subtitle: String
    var disabled: Bool = false
    var systemImage: String? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(disabled ? 0.3 : 0.9))
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .opacity(disabled ? 0.6 : 1)
                }
            }
            .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(disabled ? .secondary : .primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
                .opacity(disabled ? 0.4 : 1)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
        .opacity(disabled ? 0.6 : 1)
        .overlay(
            // Disable interactions visually; still allow container to layout the same
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.clear)
        )
    }
}

private struct DotListButton: View {
    let color: Color
    let title: String
    let subtitle: String
    var disabled: Bool = false
    var systemImage: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            DotListRow(color: color, title: title, subtitle: subtitle, disabled: disabled, systemImage: systemImage)
        }
        .buttonStyle(.plain)
        .disabled(disabled)
    }
}

// Visual content for small card row
private struct SmallCardRowContent: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
}

// Button wrapper for small card row
private struct SmallCardButton: View {
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SmallCardRowContent(title: title, subtitle: subtitle)
        }
        .buttonStyle(.plain)
    }
}

// Shared content for category row visual
private struct CategoryRowContent: View {
    let title: String
    let subtitle: String
    let tint: Color
    let systemImage: String

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(tint.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(tint)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

// Button wrapper keeping same style
private struct CategoryRowButton: View {
    let title: String
    let subtitle: String
    let tint: Color
    let systemImage: String

    var body: some View {
        Button(action: {
            // TODO: カテゴリ選択アクション
        }) {
            CategoryRowContent(title: title, subtitle: subtitle, tint: tint, systemImage: systemImage)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - CategoryRow
private struct CategoryRow: View {
    let title: String
    let subtitle: String
    let tint: Color
    let systemImage: String

    var body: some View {
        Button(action: {
            // TODO: カテゴリ選択アクション
        }) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(tint.opacity(0.12))
                        .frame(width: 44, height: 44)
                    Image(systemName: systemImage)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(tint)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - QuickActionCard
private struct QuickActionCard: View {
    let title: String
    let systemImage: String

    var body: some View {
        Button(action: {
            // TODO: アクション実装
        }) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.12))
                        .frame(width: 44, height: 44)
                    Image(systemName: systemImage)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.blue)
                }
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - NoticeRow
private struct NoticeRow: View {
    let date: String
    let title: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(date)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 80, alignment: .leading)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

// MARK: - Reusable ButtonItem (kept for the Home row)
private struct ButtonItem: View {
    let title: String
    let systemImage: String
    var isActive: Bool

    var body: some View {
        Button(action: {
            // TODO: handle tap action for \(title)
        }) {
            VStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .foregroundStyle(isActive ? Color.accentColor : Color.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    if isActive {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor.opacity(0.12))
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.08))
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Placeholder screens for other tabs
private struct PlaceholderScreen: View {
    let title: String
    let systemImage: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: systemImage)
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
                Text(title)
                    .font(.title2)
                    .bold()
                Text("この画面のコンテンツをここに実装してください。")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}


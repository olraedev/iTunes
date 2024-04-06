//
//  SearchViewModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchButtonClicked: ControlEvent<Void>
        let cancelButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let searchResult: Driver<[iTunesResult]>
    }
    
    func transform(_ input: Input) -> Output {
        let searchResult = PublishRelay<[iTunesResult]>()
        
        // too many HTTP request...
//        input.searchButtonClicked
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withLatestFrom(input.searchText.orEmpty)
//            .distinctUntilChanged()
//            .flatMap { iTunesAPIManager.fetchToiTunesSearch(term: $0) }
//            .subscribe(with: self) { owner, result in
//                let data = result.results
//                searchResult.onNext(data)
//            } onError: { _, _ in
//                print("Error")
//            } onCompleted: { _ in
//                print("Completed")
//            } onDisposed: { _ in
//                print("Disposed")
//            }
//            .disposed(by: disposeBag)
        
        input.cancelButtonClicked.bind(with: self) { owner, _ in
            searchResult.accept([])
        }
        .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText.orEmpty)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, text in
                var testData: [iTunesResult] = []
                
                testData.append(iTunesResult(
                    screenshotUrls: ["https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/f2/db/8b/f2db8b97-051a-7962-4c4a-9d56f9cf9c5d/6b76965c-bf20-46de-b040-7580ed48677f_1_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/5e/3b/c1/5e3bc17f-555f-95e6-d2ce-8c333c69b4ae/1a2101ab-1e9a-473a-a930-b077eb66c403_2_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/73/26/83/73268364-fe14-fa24-30dc-ef88a4957cc1/5b590ca0-d506-41d3-ad13-1e691f0adc95_3_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/6a/e6/b0/6ae6b092-d55e-db3e-a73d-39a85bb05a8c/589d1ee0-2a28-4b3b-8bb3-3a732324a613_4_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/88/0b/cd/880bcd94-71d5-9c48-d1b4-3e014df3ad48/7083cc52-8a0a-44a9-83b4-f09c0ab67d89_5_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/f6/ee/40/f6ee40ea-eafe-2424-b475-b34d7387ceaa/dfd9f5b6-643f-49da-b500-a5507c63f8b1_6_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/e4/20/86/e4208618-d70e-cb0a-d15e-307d54257ba0/210f205f-418e-4ccb-a340-eaaffa804e5d_7_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/db/b2/0c/dbb20cef-8fee-441d-0d8a-8ddab5deda57/c021fbcc-cd72-4b2e-abf1-f038ce14e768_8_1242_2208.jpg/392x696bb.jpg", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/89/41/88/894188f2-4f40-53d2-6698-c49b68691e0f/bc208eaa-4c08-4f1d-b07f-828f268ef49e_9_1242_2208.jpg/392x696bb.jpg"],
                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/9c/e8/a0/9ce8a012-4dcc-f049-da4b-e9b38ba401eb/AppIcon-0-0-1x_U007emarketing-0-6-0-sRGB-85-220.png/100x100bb.jpg",
                    averageUserRating: 4.729820000000000135287336888723075389862060546875,
                    trackCensoredName: "카카오 T - 택시, 대리, 주차, 바이크, 항공, 퀵",
                    sellerName: "Kakao Mobility Corp.",
                    genres: ["여행"],
                    description: "카카오 T의 혁신을 통해 모든 이동의 고민으로부터 벗어나 더 편하고, 즐겁고, 가치 있는 일상을 만들어갑니다.\n\n테마 별로 재구성된 홈 상단탭에서 원하는 서비스를 찾아 이용해보세요.\n• 홈 탭: 메인 서비스들과 신규 서비스\n• 마이카 탭: 카오너들을 위한 차량 운행/관리 서비스\n• 여행 탭: 장거리 이동에 필요한 서비스 \n\n■ 믿고 부르는, 카카오 T 택시\n• 전국에서 이용 가능한 간편 택시 호출\n• 블루/벤티/모범/블랙 원하는 택시를 자유롭게 선택\n\n■ 가까운 곳도 바이크와 킥보드로 신나게\n• 남녀노소 누구나 쉽게 타는 일반 & 전기 자전거, 카카오 T 바이크\n• 제휴 킥보드도 같은 지도에서 탐색 및 이용 가능\n• 원하는 곳 어디서나 자유롭게 이용 후 반납\n\n■ 데이터 중심의 대리운전\n• 앱으로 간편하게 대리운전 호출\n• 세심한 배려를 더한 프리미엄 대리운전 제공\n\n■ 주차 고민 끝, 편리한 주차 경험\n• 목적지 입력하면 주차장 검색 및 결제까지\n• 주차공간 걱정 없는 만차 예측 정보 제공\n\n■ 전국 시외버스, 기차, 항공 이용 시에도 카카오 T\n• 목적지 검색만으로 예매부터 결제, 발권까지 한 번에\n• KTX(코레일)부터 SRT까지 모든 기차 예매 가능\n• 항공은 국내선에 이어 국제선 예매 기능도 출시\n\n■ 안심하고 믿을 수 있는 렌터카\n• 합리적이고 믿을 수 있는 조건으로 예약부터 결제까지\n• 원하는 곳에서 대여(딜리버리)와 반납까지 (제주 지역 제외)\n\n■ 물건을 주고받을 때, 가장 쉬운 퀵·배송\n• 번거로웠던 접수를 안심하고 간편하게 T앱에서\n• 거절없이 정해진 시간 안에, 합리적 요금으로\n\n■ 댕냥이의 외출이 편해지는, 카카오 T 펫\n• 동물보호교육을 받은 메이트님과 함께하는 반려동물과의 편안하게 이동\n• 서울/경기/인천 지역에서 서비스 가능\n\n■ 카오너들을 위한 마이카 탭\n• 대리, 주차\n• 실시간 교통 정보 기반 빠르고 정확한 길 안내, 내비\n• 원하는 장소와 시간에 맞춰 부르는 방문세차와 방문정비 \n• 현금 결제, 대기 시간 없이 스마트한 발레 서비스 (카카오내비를 통해 이용)\n• 내차 정보를 확인하고 현재 시세를 알아보는 내차팔기\n\n■ 장거리 이동을 위한 여행 탭\n• 시외버스, 기차, 항공\n• 직접 만든 노선으로 대절 및 결제 가능한 셔틀\n• 해외에서도 편리한 택시 호출 (일본, 베트남에서 이용 가능)\n\n■ 일하는 사람들을 위한 카카오 T 비즈니스\n• 택시, 대리, 통근 셔틀 등 업무용 이동은 기본\n• 간편하고 스마트한 퀵·배송 접수 \n\n■ 더 간편한 결제, 카카오 T 포인트\n• 카드 등록 한 번으로, 모든 서비스 이용 요금 결제\n• 카카오 T 앱에서 사용과 선물이 가능한 카카오 T 포인트 (일부 서비스 전용)\n• 카카오 T 포인트 타운에서 포인트 적립을 위한 다양한 기회 제공\n\n※ 사용자는 카카오 T의 원활한 이용을 위해 아래의 권한을 허용할 수 있습니다. 각 권한은 그 속성 에 따라 반드시 허용해야 하는 필수 권한과 선택적으로 허용이 가능한 선택 권한으로 나뉩니다.\n\n1. 필수 허용 권한\n1) 위치: 출발지 및 목적지 설정에 사용됩니다.\n\n2. 선택 허용 권한\n1) 알림: 카카오 T에서 제공하는 각종 알림을 수신하기 위해 필요한 권한입니다.\n2) 마이크: 음성 인식을 활용하여 출발지 및 도착지를 설정할 때 사용됩니다.\n3) 카메라: QR코드 인식 및 기타 고객 제보 시 사용됩니다.\n4) 사진: 저장된 호출 상품의 정보를 읽어오는데 사용됩니다.\n5) 블루투스: 바이크 상품 이용 시 휴대폰과 바이크를 연결하는데 사용됩니다.\n6) 연락처: 상품 이용 시 전화번호 저장에 사용됩니다.\n\n※ 선택 접근 권한은 동의하지 않아도 서비스를 이용할 수 있습니다.\n※ 휴대폰 설정 > 앱 > 카카오 T 에서 접근 권한을 변경할 수 있습니다."))
                searchResult.accept(testData)
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchResult: searchResult.asDriver(onErrorJustReturn: []))
    }
}

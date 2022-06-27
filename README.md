# ChildOfWeatherSwiftUI

## 0. 개발자: July 
## 1. 프로젝트 기간: 2022.06.20 ~
## 2. 커밋 규칙
- 단위: 기능 단위
- 커밋 스타일: 카르마 스타일
## 3. 목표
- 기존 RxSwift, RxCocoa로 진행했던 프로젝트를 SwiftUI, Combine으로 migration 
## 4. 키워드      
`SwiftUI` `Combine` `async await` `actor` `Custom ViewModifier` 
  
## 5. 사용 
|날씨정보|도시검색|
|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/90888402/175926837-d0a11ceb-6c31-4358-9c85-65d117fab728.gif" width="70%">|<img src="https://user-images.githubusercontent.com/90888402/175927347-b51ebad4-7e57-447c-9e28-7d147b4729fb.gif" width="70%">|



----

## Async Await 를 사용한 비동기처리 

```swift
final class URLSessionService: URLSessionServiceProtocol {
    
    let session = URLSession.shared
    
    func request<T: APIRequest>(
        requestType: T
    ) async throws -> T.ResponseType
        {
        
        guard let request = requestType.urlRequest else {
            throw APICallError.dataNotfetched
        }
            
        guard let (data, response) = try? await session.data(for: request)
            else {
            throw APICallError.dataNotfetched
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw APICallError.notProperStatusCode
        }
            
        guard let decoded = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
            throw APICallError.failureDecoding
        }
            
        return decoded
    }
}
```
@escaping을 사용한 탈출클로저, RxSwift의 Single이나 Combine의 AnyPublisher로 비동기처리를 해주었던 부분을 Swift async await로 처리해주었습니다. 

## Data Race를 방지하기위한 Actor 

```swift
final actor DefaultCityListRepository: CityListRepository {
    
    let cityList: [City]

    init(cityList: [City] = CityList().city ?? []) {
        self.cityList = cityList
    }
    
    nonisolated func fetchCityList() -> AnyPublisher<[City], Never> {
        return Just(cityList).eraseToAnyPublisher()
    }
 ``` 
 같은 데이터가 여러개의 스레드에서 접근될 때 DataRace가 발생하는데, 이러한 부분을 actor로 타입을 만들어주어 해결하였습니다.
 또한 nonisolated로 정의한 메서드를 통해 외부에서 정보를 받아올 수 있게 하였습니다. 
 
 ## TaskBag을 통한 suspension 
 
 ```swift
 extension Task {
    
    func dispose(bag: CancelTaskBag) {
        bag.add(task: self)
    }
}
``` 

```swift
final class CancelTaskBag {
    
    private var tasks: [any Cancelable] = []
    
    public init() {}

    public func add(task: any Cancelable) {
        tasks.append(task)
    }

    public func cancel() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }
    
    deinit {
        cancel()
    }
}
``` 

데이터 Task들을 관리해주는 RxSwift의 disposeBag이나 Combine의 AnyCancellable같은걸 CancelTaskBag을 통해 
구현했습니다.<br>
레퍼런스: http://minsone.github.io/swift-concurrency-AnyCancelTaskBag

```swift
   .onAppear {
            Task {
                await self.viewModel.fetchWeather(city: self.city)
            }.dispose(bag: self.bag)
        }
        .onDisappear {
            self.bag.cancel()
        }
 ```
 이러한 TaskBag을 만들어 SwiftUI의 View가 onAppear되는 시점과 onDisappear 시점에 맞춰서 cancel과 dispose를 해주었습니다. 
 
 ---- 
 
 ## 트러블슈팅 
 
 ### 하나의 body에 너무 많은 요소가 들어가서 코드의 가독성이 떨어지는 문제 
 
 하나의 body에 많은 VStack과 NavigationLink나 NavigationView가 들어가있고 List를 표현하기 위해 
 ForEach까지 사용하다보니 코드가 너무 길어지는 문제가 발생하였고 코드 가독성이 떨어졌습니다. 
 
 해결방안
1. 함수를 사용한 코드 분리 
 ```swift 
  
    func RectangleView() -> some View {
        return  Rectangle()
            .background(
                LinearGradient(
                    colors: [Color.black, Color.blue, Color.purple],
                    startPoint: .top, endPoint: .bottom)
            )
            .opacity(0.7)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 10.0)
            .cornerRadius(10)
    }
 ```
 UpperCamelCase로 만들어진 some View를 리턴하는 함수를 만들어 UI Components들을 분리해주었습니다. 
 
 2. Custom ViewModifier 생성 
 ```swift
 **struct FontSizingMinimum: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color.white)
            .padding()
    }
}
``` 
별로의 ViewModifer로 자주 쓰이는 ViewModifier들을 하나로 묶어 코드의 양을 줄였고 재사용성 있는 코드를 만들었습니다. 

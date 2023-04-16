# Appstore iOS-App 클론

## 목차 
- [요약](#요약)
- [도입 기술](#도입-기술)
- [구현 결과](#구현-결과)
- [트러블 슈팅](#트러블-슈팅)
- [학습한 내용](#학습한-내용)


## 요약


|Index|Detail|
|------|---|
|기여|100% ( 1인 개발 진행 ) |
|구현 기간| **2023.04.12 ~ 2023.04.14**|
|구현 기능|**[공통]** <br> - CollectionView Custom  <br> - 스크롤 뷰 활용 <br> - API대신 plist데이터 활용 <br> - Share sheet
|기술 스택|- UIKit <br> - SnapKit|
|Pain Point|1. 컬렉션 뷰를 다양하게 구현하는 부분 <br> 2. 복잡한 구조|
|해결 방법|1. 기존에 한번도 다뤄본 적이 없었던 컬렉션뷰를 학습하고 적용해봤습니다. 나름 투데이 탭은 괜찮게 구현한 것 같았지만, 앱 탭에서 테이블뷰, 컬렉션뷰, 스크롤뷰(스택뷰) 중 어떤것을 활용해야 할지 고민해보았고, 스크롤뷰에 컬렉션뷰를 넣는것이 유연해서 활용성이 높을것 같다고 판단해서 스크롤뷰를 이용하여 구현하였습니다.   <br><br> 2. 복잡한 구조의 앱을 이해하고자 앱스토어 앱을 참고하면서 해당 프로젝트를 진행하였습니다. |
|아쉬운점 <br>& 느낀점|1. 앱스토어의 기능을 완벽하게 커버하지 못한 점이 너무 아쉽습니다. 가능한 비슷하게 구현했지만, 조금 더 보충해볼 생각입니다. <br> <br> 2. 3일 가량 앱스토어 서비스 클론만을 위해 시간을 투자하면서 구현해본 뷰를 체화하여 더 다양한 뷰에 대응하고 싶어서 구현방식에 대해서 많이 생각해본 것 같습니다. <br> <br> 3. 공부하는 방식으로 진행하다보니, 깃허브 관리를 소홀히 하여 add-commit-push 만 하게된것 같습니다. 혼자 진행하더라도 branch를 따서 체계적으로 관리할 수 있도록 해야겠습니다.|
|*Suggestion|**[당근마켓 다크모드]** <br> iOS13 이후 다크모드를 지원하면서 수많은 유저들이 다크모드를 사용하고 있습니다. 이에 다른 수많은 서비스들도 다크모드에 대응하고 있습니다. 이러한 배경과 함께 다크모드를 애용하는 한 명의 사용자로서, 당근마켓을 다크모드로 구현해보면 어떨까? 하는 생각으로 시도해보았습니다.|


-------------
# 🔨도입 기술
## ➡️ 이미지 캐시 구현
### 도입 이유
- CollectionView에서 스크롤마다 이미지를 불러오는 작업을 하기 때문에, 같은 네트워크 작업을 반복하는 문제가 발생했습니다.<br>

### 도입 결과
- 캐싱을 도입해서 네트워크 통신 비용을 줄일 수 있었습니다.
- 한 번 로딩한 이후부터는 이미지가 늦게 나타나는 현상을 개선하였습니다.
- CollectionView의 스크롤이 부드러워지는 것을 체감하였습니다. <br>

|캐시 도입 전|캐시 도입 후|
|:----:|:----:|
|<img src="https://user-images.githubusercontent.com/68585628/232266786-a33998de-35bb-46ea-be88-6453b785ffc5.gif" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232266813-d40b8f25-dce0-4435-a2ae-258097bb27be.gif" width="300">|

### 아쉬운 점
- CollectionView에서 이미지를 처음 로딩할 때 이미지가 늦게 나타나는 현상은 개선되지 않았습니다.
- 캐시를 도입하니 메모리가 튀는 현상은 사라졌지만, 메모리가 계속해서 이미지를 갖고 있음으로써 메모리 사용량은 높은 상태로 꾸준하게 유지 되었습니다. <br>

|캐시 도입 전|캐시 도입 후|
|----|----|
|<img src="https://user-images.githubusercontent.com/68585628/232266454-24ce7105-0746-4584-8ba9-2133504fed5c.png" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232266547-72bf5efb-b67f-4933-9516-49c5ed8b7438.png" width="300">|



# 구현 결과

|투데이|투데이 아이템 클릭|쉐어 시트|
|:----:|:----:|:----:|
|<img src="https://user-images.githubusercontent.com/68585628/232003966-79f0096a-0e28-49da-8c2e-f051e03bf9c7.gif" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232004183-5ed0c415-f0e9-4774-92bb-f60fe7ff101d.gif" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232004287-7b6c2292-5bec-4af8-9266-fa221d0b55ec.gif" width="300">|
|앱|앱 아이템 클릭|앱 리스트|
|<img src="https://user-images.githubusercontent.com/68585628/232004559-ec373de3-c26a-4f65-8b83-ca6c025a35fa.gif" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232004720-445f9ed0-5a77-4e21-9dc3-d7c03343ce83.gif" width="300">|<img src="https://user-images.githubusercontent.com/68585628/232004889-62cf8d36-0685-41ed-9035-d81af6374cf7.gif" width="300">|

## 트러블 슈팅

### weak protocol
- 문제 상황
	- weak로 delegate 프로퍼티를 Protocol을 타입으로 선언 시, 불가능 하다는 컴파일에러
- 해결 방법
	- weak는 약한참조를 위한 키워드로 당연히 클래스에만 적용된다. 이에, protocol에 AnyObject타입을 채택하여 class only protocol로 만들어줬다.


## 학습한 내용
 
#### 1. ViewController간 이벤트를 주고 받는 방법 - Delegate 패턴

> 기존의 UIView에서 present가 안되기 때문에, FeatureSectionView에서 Delegate 패턴을 통해 AppViewController로 역할을 위임하여 뷰를 present했다.
```swift
protocol FeatureSectionViewDelegate: AnyObject {
    func presentUI(_ feature: Feature)
}
```


#### 2. CollectionView
> DataSource, DelegateFlowLayout과 기본적인 CollectionView 구성 및 적용 방법



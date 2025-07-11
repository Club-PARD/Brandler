<div align="center">

# Brandler  
**iOS 패션 브랜드 탐색 및 관리 앱**

</div>

<div align="center">

패션 브랜드 추천, 탐색, 스크랩 관리까지  
SwiftUI 기반의 맞춤형 iOS 애플리케이션

</div>

---

## 1. Overview

Brandler는 세 가지 핵심 모듈로 구성됩니다:

| Module                  | 역할 설명                                                         |
|-------------------------|-------------------------------------------------------------------|
| **브랜드 데이터 & API**   | 브랜드 정보 관리, 서버와의 통신                                   |
| **사용자 관리**           | 로그인, 세션, 프로필 정보 동기화                                 |
| **위젯 추천**             | iOS 위젯에 맞춤 브랜드 추천, 타임라인 관리                       |

---

## 2. 공통 구성 요소

### 2.1. 기본 URL 및 오류 타입

| 이름         | 설명                                   |
|--------------|----------------------------------------|
| `BaseURL`    | 모든 API 요청의 기본 URL(`https://brandler.shop`) |
| `ErrorType`  | 네트워크 오류 타입(`invalidURL`, `invalidResponse`, `networkError`) |

---

## 3. 모듈별 상세 설명

### 3.1. 브랜드 데이터 및 API

#### 데이터 모델

| 모델명         | 주요 필드 및 설명                                  |
|----------------|---------------------------------------------------|
| `BrandInfo`    | 브랜드 상세 정보, scrapCount로 레벨 계산           |
| `Brand`        | 일반 브랜드 모델, isScraped, sampleData 제공       |
| `BrandCard`    | 리스트/카드용 경량 정보                            |
| `GenreBrandCard`| 장르 필드 추가된 카드                             |
| `Product`      | 브랜드별 제품 정보                                 |

#### 네트워크 API

| 클래스                | 주요 메서드 및 설명                                    |
|-----------------------|-------------------------------------------------------|
| `ScrapeServerAPI`     | 스크랩 상태 패치, 조회, 리스트 불러오기                |
| `GetBrandListViewModel`| Top10, 정렬 리스트, 최근본/스크랩/상세/제품 정보      |

#### 뷰 모델

| 클래스            | 설명                                                         |
|-------------------|-------------------------------------------------------------|
| `BrandViewModel`  | 브랜드 상태/필터/애니메이션/스크랩 동기화/레벨 시스템 관리  |

### 3.2. 사용자 관리 모듈

#### 데이터 모델

| 모델명          | 주요 필드 및 설명                        |
|-----------------|-----------------------------------------|
| `User`          | email, name, genre                      |
| `UserData`      | email, nickname, fashionGenre           |

#### 네트워크 API

| 클래스           | 주요 메서드 및 설명                                 |
|------------------|----------------------------------------------------|
| `UserServerAPI`  | 사용자 정보 업로드, 조회, 수정                      |

#### 세션 관리

| 클래스               | 설명                                                         |
|----------------------|-------------------------------------------------------------|
| `UserSessionManager` | 싱글톤, 로그인 상태/유저 데이터 관리, Google Sign-In 연동    |

### 3.3. 위젯 추천 모듈

#### 데이터 모델

| 모델명                | 주요 필드 및 설명                           |
|-----------------------|---------------------------------------------|
| `BrandRecommendation` | 위젯 추천 데이터, 서버 응답 필드 매핑        |

#### 네트워크 API

| 클래스        | 주요 메서드 및 설명                                 |
|---------------|----------------------------------------------------|
| `WidgetAPI`   | 브랜드 추천 리스트 받아오기                         |

#### 뷰 모델

| 클래스                  | 설명                                                         |
|-------------------------|-------------------------------------------------------------|
| `BrandWidgetViewModel`  | 위젯 타임라인 생성, 10초 간격 브랜드 추천                   |

---

## 4. 상호작용 흐름

- **앱 실행/로그인**: 세션 복원 및 Google 로그인
- **데이터 로드**: 브랜드/유저 정보 서버에서 불러오기
- **UI 렌더링**: SwiftUI 뷰에서 실시간 반영
- **사용자 상호작용**: 스크랩, 프로필 수정, 필터링 등
- **서버 동기화**: 변경사항 서버 반영
- **위젯 업데이트**: 위젯에 맞춤 추천 반영

---

## 5. 기능 명세서

### Splash Page

| 기능         | 설명                                   |
|--------------|----------------------------------------| 
| 애니메이션   | 위/아래에서 합쳐진 후 작아지는 효과     |

 <p align="center">
  Splash
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bc65e23a-e16a-4c02-9027-10d1ce8b69cd" alt="Splash" width="320"/>
</p>

---

### Login Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| Google 로그인| 이메일 받아와 UI에 표시                |

 <p align="center">
Login / Login after Logout / Login after Login
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/11695449-e114-4227-aa78-1d1e7c23f341" alt="Google Login" width="320"/>
     <img src="https://github.com/user-attachments/assets/6ce0d309-e79e-4b94-8907-23059ef0fda2" alt="logout-in" width="320"/>
    <img src="https://github.com/user-attachments/assets/7aee393f-a10b-41ba-9188-9245a6037392" alt="LoginRight" width="320"/>  

</p>

---

### OnBoarding Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 정보 저장    | 닉네임, 장르 저장, 이미지 회전 애니메이션|
| 서버 연동    | Email 기반 정보 저장                   |

 <p align="center">
OnBoarding
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/03f7c4ac-9caa-4b40-a033-16c26294b0e9" alt="OnBoarding" width="320"/>
</p>

---

### Main Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 브랜드 추천  | 장르 기반 추천, 탭 전환, 스크랩 제외   |
| 애니메이션   | 자동 배너, 장르 전환 효과              |
| 서버 연동    | Top10, 정렬, 스크랩/유저 정보 불러오기 |

 <p align="center">
Banner and Filtering
</p>

<p align="center">
    <img src="https://github.com/user-attachments/assets/7d8ed9a5-84cb-4222-879e-12d45c278cc4" alt="Banner" width="320"/>
  <img src="https://github.com/user-attachments/assets/81fd491f-c809-42a7-bcf6-ff112746dc51" alt="screen" width="320"/>
</p>

---

### Search Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 최근 검색어  | 표시 및 서버 검색 결과 연동            |

 <p align="center">
Search
</p>

 <p align="center">
  <img src="https://github.com/user-attachments/assets/b9bd4032-96f8-4135-b7b1-e1f9b58977a6" alt="searcch" width="320"/>
  <img src="https://github.com/user-attachments/assets/8b0011b3-c0c0-420b-884c-8a14cd9b3d47" alt="Search Delete" width="320"/>
</p>

---

### Brand Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 상세 설명    | 더보기, 캐릭터 변화, 하트 아이콘        |
| 필터/이동    | 카테고리 필터, 홈페이지 이동            |
| 애니메이션   | 배너/제품 클릭 효과                    |
| 서버 연동    | 스크랩 상태 업데이트/조회               |

 <p align="center">
Brand
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/9948d199-83ef-4831-932e-0b8217a3ca66" alt="brand" width="320"/>
</p>

---

### Scrape Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 스크랩 관리  | 삭제, 최근순 정렬, 카드 플립/페이지 넘김|
| 서버 연동    | 삭제/조회                              |

 <p align="center">
Empty Scrape
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/9500e94c-70bd-4a07-a998-f95f1f4a3437" alt="Empty Scrape" width="320"/>
  <img src="https://github.com/user-attachments/assets/9f0f95d0-3cb3-43f9-9acb-84e5389cd643" alt="FlipCard and Swipe" width="320"/>
</p>

---

### 단계 레벨 가이드

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 단계 가이드  | 모달/탭/오버레이 구성                  |


 <p align="center">
Digging
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/87b2a288-b35f-4f1d-b930-010a86f9d0af" alt="diggin" width="320"/>
</p>

---

### User Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 캐릭터/레벨  | 스크랩 수에 따라 변화, 진행도 애니메이션|
| 서버 연동    | 최근 스크랩/접속 브랜드 3개 정보 불러오기|

 <p align="center">
User Page
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/db8c669e-e94f-47f7-a298-340c3576a7df" alt="User Page" width="320"/>
</p>

---

### History Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 최근 본 브랜드| 리스트 표시 및 서버 연동               |


 <p align="center">
History
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/b4e6e14c-8aae-4f0b-ad4b-fe49b2329639" alt="History Page" width="320"/>
</p>

---

### Edit Page

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 로그아웃/수정| 닉네임/장르 수정, 서버 반영            |

 <p align="center">
Edit Page
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/5b4b314c-bf76-4b38-86b9-cda13ac3c6a4" alt="Edit Info" width="320"/>
</p>

---

### Widget

| 기능         | 설명                                   |
|--------------|----------------------------------------|
| 자동 갱신    | 10초마다 브랜드 추천 갱신              |
| 서버 연동    | 알고리즘 기반 브랜드 리스트 불러오기    |
 <p align="center">
Widget
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/900a6588-4822-4fa3-bc51-fdac060ee5fd" alt="Widget 1" width="320"/>
  <img src="https://github.com/user-attachments/assets/93dc6fc3-7b35-438c-ac9b-5e2deaa814dd" alt="Widget 2" width="320"/>
</p>

---

## 기타 정보

- 캐릭터 레벨/이미지 변화는 스크랩 수 기준
- 브랜드 정렬은 MVP 기반 알고리즘 자동 수행
- 모든 정보는 사용자 Email 기반으로 관리

---

<div align="center" style="color:#1877f2; font-weight: bold; font-size: 1.1em;">
Brandler, Your Personalized Fashion Brand Explorer for iOS
</div>

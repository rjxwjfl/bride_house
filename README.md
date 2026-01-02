# 👰 BrideHouse (Admin)
> **Wedding Dress Rental Management System**
> 드레스 대여샵 관리자를 위한 모바일 상품 검수 및 재고 관리 애플리케이션

![Project Status](https://img.shields.io/badge/Status-Active-success)
![Version](https://img.shields.io/badge/Version-1.0.0-blue)
[![Flutter](https://img.shields.io/badge/Flutter-3.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-18-339933?logo=nodedotjs&logoColor=white)](https://nodejs.org/)

## 📖 Project Background (기획 배경)

본 애플리케이션은 샵 매니저가 모바일 앱을 통해 드레스의 출고/반납 상태를 즉시 체크하고, 사진과 함께 기록을 남겨 분쟁을 예방하며 효율적인 재고 관리를 돕기 위해 개발됨.

## ✨ Key Features (핵심 기능)

### 1. 🔍 QR/Barcode Scanner (상품 식별)
* 드레스 태그의 QR/바코드를 스캔하여 상품 정보 즉시 호출.
* 수기 입력 오류 방지 및 신속한 상품 조회 가능.

### 2. 📝 Check-in & Check-out (입출고 검수)
* **대여(Out):** 출고 전 드레스 상태(비즈 탈락, 오염 등)를 체크리스트로 확인.
* **반납(In):** 반납된 드레스의 손상 여부 확인 및 **현장 사진 업로드**를 통한 증빙 데이터 저장.

### 3. 📊 Dashboard & Inventory (현황판)
* 대여 중 / 세탁 중 / 수선 필요 등 드레스 상태별 현황 실시간 모니터링.
* 날짜별 대여 스케줄 캘린더 뷰 제공.

### 4. 🔔 Alert System (알림)
* 반납 예정일 초과 미반납 상품에 대한 경고 알림 발송.
* 수선/세탁 완료 예정일 알림을 통한 일정 관리 지원.

## 🛠 Tech Stack (기술 스택)

| Category | Technology |
| --- | --- |
| **Mobile App** | Flutter (Dart) |
| **Backend** | Node.js (Express) |
| **Database** | MySQL / Firebase (인증) / Google Cloud Storage |
| **State Mgt** | Provider / Riverpod / BloC |
| **CI/CD** | Github Actions |

*(본인이 실제로 사용한 기술로 바꿔주세요)*

## 📱 Service Flow (서비스 흐름)

```mermaid
sequenceDiagram
    participant Manager as 관리자
    participant App as 앱(Client)
    participant Server as 서버
    
    Manager->>App: 1. 드레스 태그 스캔 (QR)
    App->>Server: 상품 정보 요청
    Server-->>App: 드레스 데이터 반환 (ID: 1024)
    Manager->>App: 2. 상태 점검 및 사진 촬영
    Manager->>App: 3. '대여 확정' 버튼 클릭
    App->>Server: 상태 업데이트 (Status: RENTED)
    Server-->>App: 처리 완료 확인

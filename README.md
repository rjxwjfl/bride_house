# 👰 BrideHouse (Admin)
> **Wedding Dress Rental Management System**
> 드레스 대여샵 관리자를 위한 모바일 상품 검수 및 재고 관리 애플리케이션

![Project Status](https://img.shields.io/badge/Status-Active-success)
![Version](https://img.shields.io/badge/Version-1.0.0-blue)
[![Flutter](https://img.shields.io/badge/Flutter-3.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-18-339933?logo=nodedotjs&logoColor=white)](https://nodejs.org/)

## 📖 Project Background (기획 배경)
고가의 웨딩 드레스는 대여와 반납 과정에서 **오염, 파손, 분실** 등의 이슈가 빈번하게 발생합니다. 기존의 수기 장부나 엑셀 관리는 실시간 상태 확인이 어렵고, 히스토리 추적이 불가능하다는 단점이 있었습니다.

**BrideHouse**는 샵 매니저가 모바일 앱을 통해 드레스의 출고/반납 상태를 즉시 체크하고, 사진과 함께 기록을 남겨 분쟁을 예방하며 효율적인 재고 관리를 돕기 위해 개발되었습니다.

## ✨ Key Features (핵심 기능)

### 1. 🔍 QR/Barcode Scanner (상품 식별)
* 드레스 태그의 QR/바코드를 스캔하여 즉시 상품 정보를 불러옵니다.
* 수기 입력 없이 빠르고 정확한 상품 조회가 가능합니다.

### 2. 📝 Check-in & Check-out (입출고 검수)
* **대여(Out):** 나가는 드레스의 상태(비즈 탈락 여부, 오염 등)를 체크리스트로 확인합니다.
* **반납(In):** 반납된 드레스의 손상 여부를 확인하고, **현장 사진을 업로드**하여 DB에 저장합니다.

### 3. 📊 Dashboard & Inventory (현황판)
* 현재 대여 중인 드레스, 세탁 중인 드레스, 수선이 필요한 드레스 현황을 한눈에 파악합니다.
* 날짜별 대여 스케줄 캘린더 뷰를 제공합니다.

### 4. 🔔 Alert System (알림)
* 반납 예정일이 지난 미반납 상품에 대한 경고 알림.
* 수선 완료 예정일 알림 등 관리자 업무 보조.

## 🛠 Tech Stack (기술 스택)

| Category | Technology |
| --- | --- |
| **Mobile App** | Flutter (Dart) or React Native |
| **Backend** | Node.js (Express) or Python (Django/FastAPI) |
| **Database** | PostgreSQL / Firebase (이미지 저장용) |
| **State Mgt** | Provider / Riverpod / Redux |
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

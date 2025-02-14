# Git CLI for Actions

**Git CLI for Actions**는 Git이 설치되지 않은 환경에서도 Git 명령을 실행할 수 있도록 하는 GitHub Action입니다.  
Docker 컨테이너 내부에서 Git을 실행하며, GitHub Actions 러너와 작업 디렉토리를 공유하여 원활한 Git 작업을 지원합니다.

---

## 주요 기능
- Git이 없는 환경에서도 `git` 명령 실행 가능
- Docker 기반 실행으로 일관된 환경 제공
- GitHub Actions 러너의 작업 디렉토리와 연동
- 기존 Git CLI와 동일한 명령어 사용 가능

---

## 사용법

### 사용 예시
아래와 같이 `.github/workflows/main.yml` 파일을 생성하고, `Git CLI for Actions`를 실행할 수 있습니다.

```yaml
name: Git CLI Test
on: [push]

jobs:
  git-test:
    runs-on: github-runner
    steps:
      - name: 저장소 체크아웃
        uses: actions/checkout@v4

      - name: Git 상태 확인
        uses: KangYoungIn/git-cli-for-actions@v1.0.0
        with:
          command: 'status'

      - name: 최신 변경사항 가져오기
        uses: KangYoungIn/git-cli-for-actions@v1.0.0
        with:
          command: 'pull origin main'
```

---

### 입력 값 (Inputs)

| 이름 | 필수 여부 | 기본값 | 설명 |
|------|---------|--------|------|
| `command` | 필수 | `status` | 실행할 Git 명령어 (예: `pull`, `commit -m "메시지"`, `push`) |

---

## 내부 동작 방식

1. GitHub Actions 러너에서 실행
2. Git이 포함된 Docker 컨테이너를 실행
3. `$GITHUB_WORKSPACE`를 컨테이너에 마운트하여 호스트 작업 디렉토리와 공유
4. `git` 명령을 실행하고 결과를 출력
5. 컨테이너 종료 후 결과 반영
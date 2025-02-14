#!/bin/bash
set -e

cd /repo  # 컨테이너 내부에서 호스트의 Git 디렉토리로 이동

echo "Running Git command inside Docker: git $@"
git "$@"

#!/bin/bash

echo "🧪 테스트 환경으로 Flutter 앱 실행 중..."
echo "🌍 환경: 테스트"
echo "📱 Firebase 프로젝트: youmr-test"
echo ""

flutter run --dart-define=ENVIRONMENT=test

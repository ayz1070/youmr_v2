#!/bin/bash

echo "🚀 프로덕션 환경으로 Flutter 앱 실행 중..."
echo "🌍 환경: 프로덕션"
echo "📱 Firebase 프로젝트: youmr-v2"
echo ""

flutter run --dart-define=ENVIRONMENT=production

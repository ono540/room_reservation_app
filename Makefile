SHELL := /bin/bash
dir=${CURDIR}

# プロジェクトでよく使用するコマンドを登録する。
# ！！パスワードなど、秘匿性の高い情報は含めないこと！！
#
ff:
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

ffw:
	@fvm flutter pub run build_runner watch

fc:
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

oi:
	@open ios/Runner.xcworkspace

om:
	@open macos/Runner.xcworkspace

.PHONY: macos clean
macos:
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build macos
	@open build/macos/Build/Products/Release/

ios-clean:
	@echo "Cleaning iOS dependencies..."
	cd ios && rm -rf Pods Podfile.lock && pod install --repo-update

macos-clean:
	@echo "Cleaning macOS dependencies..."
	cd macos && rm -rf Pods Podfile.lock && pod install --repo-update

flutter-clean:
	@echo "Cleaning Flutter environment..."
	flutter clean
	flutter pub get

all-clean: ios-clean macos-clean flutter-clean
	@echo "All clean tasks completed."
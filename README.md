<div id="top"></div>

## 使用技術一覧

<!-- シールド一覧 -->
<!-- 該当するプロジェクトの中から任意のものを選ぶ-->

<p style="display: inline">
  <!-- クロスプラットフォームのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Flutter-000000.svg?logo=flutter&style=for-the-badge">
  <!-- インフラ一覧 -->
  <img src="https://img.shields.io/badge/-FireBase-000000.svg?logo=firebase&style=for-the-badge">
</p>

## 目次

1. [プロジェクトについて](#プロジェクトについて)
2. [環境](#ディレクトリ構成)
3. [開発環境構築](#開発環境構築)
4. [開発方法](#開発方法)
5. [テンプレート](#テンプレート)

## AIzuchi

ChatGPT を活用した
チャット型ジャーナリングアプリ

<!-- プロジェクトについて -->

## プロジェクトについて

#### 配信ストア

- App Store
- Google Play Store

#### リリース日

- 4 月リリース

#### 開発手法

- スクラム

<p align="right">(<a href="#top">トップへ</a>)</p>

## ディレクトリ構成

![aizuchi](https://github.com/junjun-1345/aizuchi_app/assets/76525601/228b09f9-fed7-4701-a404-f436265ca6ee)

<p align="right">(<a href="#top">トップへ</a>)</p>

## 開発環境構築

### 開発、ステージング、本番環境を作成予定

### 起動方法

1. 環境変数を共有
2. .env を作成
3. `$ flutter pub run build_runner build --delete-conflicting-outputs`
4. main.dart から run を押す。（現状）

<p align="right">(<a href="#top">トップへ</a>)</p>

## 開発方法

1. スプリントミーティングでアサインする issue を決める
2. タグの名前/issue_issue 番号\_issue 内容でブランチを切る
3. PR を作成
4. PR は全員でレビュー（何もなければ、aprrove or LGTM とコメント）
5. スプリントレビューでレビューを受ける
6. 修正があった場合は、fix/issue_issue 番号\_issue 内容でブランチを切る
7. 修正完了後、マージ

<p align="right">(<a href="#top">トップへ</a>)</p>

## テンプレート

### issue

```
## 背景

## 工数（ストーリーポイント）

- 1,2,3,5,8,12,

## 受入条件

- [ ]

## 備考

```

### PR (タイトルにも#issue 番号)

```
## チャット新機能 #issue番号

### コード修正点・追加点
-

### Q&A

### スクリーンショット

```

<p align="right">(<a href="#top">トップへ</a>)</p>

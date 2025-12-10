# my-hack-planner カスタムエージェントガイド

このガイドでは、**my-hack-planner** カスタムエージェント（`my-hack-planner.agent.md`）を使って Product Backlog Item (PBI) の実装プランを作成する方法を説明します。my-hack-planner エージェントはプラン専用であり、コード実装を直接行うわけではありません。

> **Note**: VS Code 1.106（2025年10月）より前のバージョンでは、カスタムエージェントは「chat mode」と呼ばれ、`.chatmode.md` ファイルを `.github/chatmodes/` ディレクトリに配置していました。機能は同じですが、用語と配置場所が変更されています。

## 📋 概要

このプロジェクトは 2 フェーズ構成の GitHub Copilot ワークフローを採用しています。

1. **プランニングフェーズ**: **my-hack-planner** カスタムエージェントを使用して詳細な実装プランを作成
2. **実装フェーズ**: **Agent** カスタムエージェントを使用して、プランに沿って段階的に実装

この流れにより、すべてのコード変更が十分に計画され、適切にテストされ、エンジニアリング基本原則を順守できます。

## 🎯 前提条件

GitHub Copilot で開発を始める前に:
- VS Code で GitHub Copilot を利用できることを確認
- プロジェクトの [engineering fundamentals](../.github/engineering-fundamentals.md) を理解
- コードベースの構造に慣れておく

## 📝 ステップバイステップのワークフロー

### Step 1: PBI を文書化する

実装したい内容を記述した PBI ドキュメントを作成します。

1. `.copilot-tracking/pbi/` に PBI ファイルを作成
   - 参考用のサンプル (`pbi-001.md`, `pbi-002.md`) が同ディレクトリに存在（Fruit Prices API と対応する Terraform インフラの例）
2. 命名規則: `pbi-<issue#>.md`（例: `pbi-327.md`）
3. 記載事項:
   - **Title**: 機能の明確で簡潔な説明
   - **Description**: 何を、なぜ実装するのか
   - **Acceptance Criteria**: タスク完了の判断基準
   - **Technical Requirements**: 技術的制約や必須条件

### Step 2: my-hack-planner カスタムエージェントに切り替える

1. VS Code で GitHub Copilot Chat を開く
2. モードセレクター（"Ask"、"Edit"、"Plan"、"Agent" など）をクリック
3. **"my-hack-planner"** カスタムエージェントを選択

my-hack-planner エージェントは以下に特化しています。
- 実装コードではなくプランを作成する
- プロジェクト内の既存パターンや構造を調査
- 複雑なタスクを扱いやすいフェーズに分解

### Step 3: プランの生成を依頼する

PBI ファイルをハッシュタグで参照し、プラン作成を依頼します。

**プロンプト例:**
```
Create a plan for #pbi-001.md
```

my-hack-planner は以下を実施します。
- PBI の要件を分析
- 既存コードベースを調査してパターンを把握
- 詳細なプランを `.copilot-tracking/plans/` に保存
- 調査ノートを `.copilot-tracking/research/` に保存

### Step 4: プランのレビューと改善

1. `.copilot-tracking/plans/pbi-<issue#>.plan.md` を開く
2. 各フェーズ・タスクの網羅性を確認
3. プランに以下が含まれているか確認:
   - 明確なタスク説明
   - 各タスクの成功条件
   - テストの作成・実行タスク
   - 正しいファイル配置と依存関係

改善が必要な場合:
- my-hack-planner に特定フェーズの詳細化を依頼
- 必要に応じて手動修正
- 複雑なタスクには追加の説明を要求
- エンジニアリング基本原則が満たされているか確認

### Step 5: フィーチャーブランチを作成

実装に入る前に新しいブランチを作成します。

```bash
git checkout -b feat/your-name/<issue#>-<short-description>
```

**例:**
```bash
git checkout -b feat/drew/327-api-rate-limiting
```

### Step 6: Agent カスタムエージェントに切り替える

1. GitHub Copilot Chat で、カスタムエージェントを "my-hack-planner" から **"Agent"** に変更
2. Agent エージェントは実装向けに設定されており、プロジェクトのコーディング標準に従うよう構成済み

### Step 7: フェーズごとに実装

プランファイルを `#` 記法で参照しながら、1 フェーズずつ着実に進めます。

**第1フェーズ依頼例:**
```
Implement Phase 1 of #pbi-001.plan.md
```

Agent は以下を行います。
- プランに記載されたタスクを順に実装
- プロジェクトのエンジニアリング基本原則を順守
- プランで指定されたテストを作成
- 既存のコードパターンに倣う

### Step 8: 各フェーズのレビューとテスト

各フェーズの実装後に次を実施します。

**生成されたコードのレビュー:**
   - プロジェクトのコーディング標準に従っているか
   - プランの成功条件を満たしているか
   - 必要なファイルが作成・変更されているか

### Step 9: 進捗をコミット

フェーズを完了し、テストに成功したらコミットします。

```bash
git add .
git commit -m "feat: implement phase X of PBI #<issue#>

- Completed task 1
- Completed task 2
- All tests passing"
```

### Step 10: 繰り返し

残るフェーズについて Step 7〜9 を繰り返します。

1. 次のフェーズの実装をリクエスト
2. 出力をレビューしテスト
3. 成功したらコミット
4. プランの進捗を更新

## 🔧 上級者向けヒント

### 複雑なプランへの対応

大規模な機能では以下を検討してください。
- プランを小さく焦点の合ったタスクに分割
- 重要な設計判断には ADR (Architecture Decision Record) を作成
- 共有コンポーネントに影響する場合はチームメイトと連携

### プラン変更の取り扱い

元のプランから外れる必要がある場合:
1. 理由をリサーチファイルに記録
2. 新しいアプローチに合わせてプランを更新
3. 重大なアーキテクチャ変更には ADR の作成を検討

## 📚 関連ドキュメント

- [Engineering Fundamentals](../../.github/engineering-fundamentals.md) – コード品質とテスト標準
- [Copilot Instructions](../../.github/copilot-instructions.md) – 実装ガイドライン

# GitHub Copilot HVE（Hypervelocity Engineering）ハンズオンラボ

## 🧠 概要

このプロジェクトは、GitHub Copilot と HVE(Hypervelocity Engineering) を活用したハンズオンラボを通じて、AIアシスト開発の生産性を最大化する方法を学ぶためのものです。プロジェクト固有のカスタム指示の作成、高度なカスタムエージェントの利用、実践的な開発ワークフローの導入について体験できます。

ラボの完了時には、次のことができるようになります。

- Visual Studio Code で GitHub Copilot をセットアップして構成する
- slash コマンド、チャットモード、Agentモードを効果的に使う
- プロジェクトに合わせたカスタム指示とカスタムエージェントを作成する

## ✅ 事前準備

開始する前に、次を用意してください。

- Visual Studio Code がインストールされていること
- GitHub Copilot のサブスクリプション
- ソフトウェア開発の基本的な知識
- プロジェクトの技術スタックへの理解

## 🛠️ セットアップ手順

1. このリポジトリを Fork するか Clone します。
2. Visual Studio Code でプロジェクトを開きます。

## 📁 プロジェクト構成

```
├── .copilot-tracking/      # ハンズオン演習用のサンプル PBI
│   └── pbi/
│       ├── pbi-001.md      # Daily Fruit Prices API の作成
│       └── pbi-002.md      # Terraform による IaC の作成
├── .github/         # GitHub Copilot 構成テンプレート
├── docs/                   # ラボの手順とガイド
│   ├── basic/              # 初級チュートリアル
│   │   ├── step-1-setup.md
│   │   ├── step-2-simple-chat-usage.md
│   │   └── step-3-chat-customization.md
│   └── medium/             # 中級ガイド
│       ├── archdiagram-agent-guide.md
│       ├── planner-agent-guide.md
│       └── prreview-agent-guide.md
├── examples.github.zip     # ラボ 2 以降で使用するカスタムエージェントと指示
└── hands-on-labs.md       # 本ファイル
```

## 🚀 クイックスタート

1. プロジェクトを Visual Studio Code で開きます。
2. 次のラボを順番に実施します。

## 🧪 ラボの概要

### 🔹 ラボ 1: GitHub Copilot を使い始める

3 つのステップを通じて GitHub Copilot の基本を習得します。

**Step 1: GitHub Copilot をセットアップする**  
Visual Studio Code で GitHub Copilot をインストールして構成し、利用可能な機能を理解し、開発環境を整えます。

**Step 2: GitHub Copilot Chat を使う**  
slashコマンド、Chatモード、Agentモードの使い方を身につけ、GitHub Copilotと効果的に連携する方法を理解します。

**Step 3: GitHub Copilot をカスタマイズする**  
プロジェクトのニーズに合わせたカスタム指示とカスタムエージェントを作成し、特定の開発シナリオでのコンテキスト認識を高めます。

**Step 4: プロジェクト固有の Copilot 設定を構築する**  
ルートディレクトリに`.github` フォルダーを作ります。
`.github` ディレクトリに `copilot-instructions.md` と `engineering-fundamentals.md` を定義します。

> **注:** [microsoft/edge-ai](https://github.com/microsoft/edge-ai) リポジトリの [`prompt-builder.chatmode.md`](https://github.com/microsoft/edge-ai/blob/main/.github/chatmodes/prompt-builder.chatmode.md) を参照してください。ビルダーツールの例が確認できます。

ラボ用の事前定義済みカスタムエージェントと指示はダウンロードリンクから提供されます。

**📄 ラボファイル:**
- [`docs/basic/step-1-setup.md`](docs/basic/step-1-setup.md)
- [`docs/basic/step-2-simple-chat-usage.md`](docs/basic/step-2-simple-chat-usage.md)
- [`docs/basic/step-3-chat-customization.md`](docs/basic/step-3-chat-customization.md)

### 🔹 ラボ 2: Daily Fruit Prices API を実装する

Product Backlog Item（PBI）から実行可能な実装計画を生成できるカスタムエージェントを作成し、その計画に従ってソリューションを実装します。

**進め方:**
1. Daily Fruit Prices API に関する PBI 要件を確認します。
2. カスタムエージェントを使用して詳細な実装プランを作成します。
3. プランに沿って API を実装します。
4. カスタムエージェントで Pull Request レビューを実施します。
5. 指摘事項に対応し、コードを修正します。

**📄 ラボファイル:**
- [`.copilot-tracking/pbi/pbi-001.md`](.copilot-tracking/pbi/pbi-001.md) - PBI 要件
- [`docs/medium/planner-agent-guide.md`](docs/medium/planner-agent-guide.md) - my-hack-planner カスタムエージェントの利用ガイド
- [`docs/medium/prreview-agent-guide.md`](docs/medium/prreview-agent-guide.md) - my-hack-pr-review カスタムエージェントの利用ガイド

### 🔹 ラボ 3: Terraform インフラストラクチャを実装する

アーキテクチャを可視化するカスタムエージェントを作成します。

**進め方:**
1. Terraform インフラストラクチャに関する PBI 要件を確認します。
2. ラボ 2 で定義したカスタムエージェントを使って実装プランを作成します。
3. プランに従って Terraform コードを実装します。
4. カスタムエージェントで Terraform コードからアーキテクチャ図を生成します。
5. インフラストラクチャ設計を文書化し、レビューします。

**📄 ラボファイル:**
- [`.copilot-tracking/pbi/pbi-002.md`](.copilot-tracking/pbi/pbi-002.md) - PBI 要件
- [`docs/medium/planner-agent-guide.md`](docs/medium/planner-agent-guide.md) - my-hack-planner カスタムエージェントの利用ガイド
- [`docs/medium/archdiagram-agent-guide.md`](docs/medium/archdiagram-agent-guide.md) - my-hack-arch-diagram カスタムエージェントの利用ガイド

## 📚 参考資料

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/overview)
- [GitHub Copilot Chat](https://docs.github.com/en/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide)
- [Prompt Engineering for GitHub Copilot](https://docs.github.com/en/copilot/using-github-copilot/prompt-engineering-for-github-copilot)

# my-hack-arch-diagram カスタムエージェントガイド

このガイドでは、**my-hack-arch-diagram** カスタムエージェント（`my-hack-arch-diagram.agent.md`）を使用して、既存の Terraform (IaC) コードから環境に合わせた正確な Mermaid アーキテクチャ図を直接生成する方法を説明します。my-hack-planner ガイドと同じスタイルで構成されていますが、実装計画ではなくインフラ可視化に特化しています。

> 目的: Terraform のリソース（modules、resources、data sources）を手作業の描画なしで最新の図に変換する。

## 🧭 概要

my-hack-arch-diagram エージェントは Terraform (`.tf`) ファイルを解析し、Mermaid の ELK レイアウトを用いたアーキテクチャ図（全体像やレイヤー別のビュー: 概要、ネットワーク、セキュリティ、アプリケーションなど）を生成します。構造的な変更があった場合のみ再生成するため、差分検知によって不要な更新を防ぎます。

## ✅ 前提条件

- リポジトリ内に Terraform コードが存在すること（例: `infra/terraform/.../main.tf`）
- 既存の図（任意）として `docs/diagrams/` 配下にファイルがある場合は比較対象として利用
- IaC フォルダー構成を基本的に理解していること

## 🎯 このエージェントを使うタイミング

my-hack-arch-diagram カスタムエージェントは次のような場合に利用します。
- 初めて環境図を生成したい
- インフラ変更後に図を更新したい
- 既存の図が最新かどうかを素早く確認したい（変更なしパターンの検証）

Terraform コードの作成や計画策定には使用しません。それらは my-hack-planner や Agent カスタムエージェントの役割です。

## ⚡ クイックスタート

1. my-hack-arch-diagram カスタムエージェントに切り替える
2. 対象パスまたはファイルを指定する: `Create arch diagram for #infra/terraform/environment/dev/main.tf`
3. エージェントが以下を実行:
    - 関連する `.tf` ファイルの探索
    - 既存の図ファイルの検出
    - IaC とドキュメントの状態を比較
    - 構造変化が見つかった場合に図を生成・更新
4. `docs/diagrams/` 配下に生成されたファイルを確認

最小限のプロンプト例:
```
Create arch diagram for #infra/terraform/environment/dev/main.tf
```

モジュールに集中したい場合:
```
Create arch diagram for #infra/terraform/modules/network/main.tf
```

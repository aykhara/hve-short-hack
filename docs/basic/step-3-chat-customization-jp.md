## ステップ 3: GitHub Copilot をカスタマイズする

### 概要
ステップ 3 では、GitHub Copilot の挙動をカスタマイズする方法を学びます。プロジェクト固有のカスタムインストラクションを作成し、専門タスク向けに再利用できるカスタムエージェントを設定する手順を確認します。所要時間の目安は 10〜20 分です。

### 事前条件
事前に以下を完了しておいてください。

- **ステップ 1**（GitHub Copilot のインストールとサインイン）
- **ステップ 2**（Copilot Chat の基本操作に慣れている）
- **VS Code の基本操作**（ファイルを開く、編集する、フォルダーを作成するなど）

### 学ぶ内容
このステップの終了時点で、次のことができるようになります。

- プロジェクト向けのカスタムインストラクションファイルを作成する
- Copilot に守らせたいルールやガイドラインを記述する
- 特定タスク用のカスタムエージェントを作成する
- 目的に応じてカスタムエージェントを切り替える

### クイックフロー
1. カスタムインストラクションファイルを作成する
2. インストラクションを記述して動作を確認する
3. カスタムエージェントを作成する
4. カスタムエージェントを試して使いこなす

---

## 詳細手順

### 1. カスタムインストラクションを理解する

GitHub Copilot は、プロジェクト内の特別なファイルからカスタムインストラクションを読み取ります。このファイルを使うと、Copilot に次のようなことを伝えられます。
- 望ましいコーディングスタイルや命名規則
- プロジェクト固有のルール
- コード生成時に守ってほしい注意点
- ドキュメントの書き方や必須要素

インストラクションファイルは `.github` フォルダー内の `copilot-instructions.md` です。

### 2. インストラクションファイルを作成する

2-1. **`.github` フォルダーを作成する**（まだ存在しない場合）

   - VS Code のエクスプローラーでプロジェクトルートを右クリック
   - 「新しいフォルダー」を選択
   - フォルダー名を `.github` にする

2-2. **インストラクションファイルを作成する**

   - `.github` フォルダーを右クリック
   - 「新しいファイル」を選択
   - ファイル名を `copilot-instructions.md` にする

   ファイルパスは `.github/copilot-instructions.md` になります。  
   ![Creating copilot-instructions.md](./images/chat-customization/chat-create-instruction.png)

### 3. シンプルなカスタムインストラクションを書く

ここからは Copilot に基本的なガイドラインを伝えるための内容を追加します。

3-1. **Frontmatterを追加する**

`copilot-instructions.md` の冒頭に次の内容を追加します。
```markdown
---
applyTo: "**"
---
```

- `applyTo: "**"` は、このインストラクションがプロジェクト内のすべてのファイルに適用されることを意味します。
- "*.py" のように特定のファイルパターンを指定することで、対象を絞り込むこともできます。

   ![applyTo example](./images/chat-customization/chat-apply-to.png)

3-2. **最初のインストラクションを書く**

Frontmatterの下に、基本的なガイドラインを追加します。
```markdown
# プロジェクトのコーディングガイドライン

## コードスタイル
- 複雑なロジックには必ずコメントを追加する
- 説明的な変数名を使う
- Python コードでは PEP 8 スタイルガイドに従う
- 意味のあるコミットメッセージを残す

## ドキュメント
- すべての関数とクラスに docstring を追加する
- 必要に応じて docstring にサンプルコードを含める
   
## エラーハンドリング
- 組み込み例外ではなくカスタム例外クラスを利用する
- 問題となった値を含めた詳細なエラーメッセージを出力する
```

必要に応じて自分のチームのルールに書き換えてください。  
   ![Sample instructions](./images/chat-customization/chat-add-instructions.png)

3-3. **言語別のインストラクションを追加する（任意）**

特定の言語に絞ったルールを追加することもできます。
```markdown
## Python ガイドライン
   - Prefer list comprehensions over loops when appropriate
   - Use f-strings for string formatting
   - ALWAYS add type hints to all function parameters and return types
   - Add input validation at the start of each function to check parameter types
   - Include usage examples in docstrings using the >>> format
   - Log function entry and exit using print statements for debugging
   - Use `pydantic` for data validation and settings management

   - 適切な場合はループよりもリスト内包表記を優先する
   - 文字列のフォーマットには f-strings を使用する
   - すべての関数のパラメーターと戻り値にタイプヒントを必ず付ける
   - 各関数の冒頭でパラメーターの型を検証する入力バリデーションを追加する
   - docstring には >>> 形式の使用例を含める
   - デバッグ用に print 文を使用して関数の開始と終了をログ出力する
   - データバリデーションと設定管理には `pydantic` を使用する

## JavaScript/TypeScript ガイドライン
   - Use `const` by default, `let` only when reassignment is needed
   - Prefer arrow functions for callbacks
   - Use async/await instead of promise chains
   
   - デフォルトで `const` を使用し、再代入が必要な場合のみ `let` を使用する
   - コールバックにはアロー関数を優先する
   - Promise チェーンではなく async/await を使用する
```

   ![Language-specific instructions](./images/chat-customization/chat-add-language-specific-instructions.png)

3-4. **ファイルを保存する**

   - `Ctrl+S`（Windows/Linux）または `Cmd+S`（macOS）で保存します。
   - Copilot は自動的にこのインストラクションを検出し、以降の提案に反映します。

### 4. カスタムインストラクションをテストする

作成したインストラクションが機能しているか確認しましょう。

4-1. **Copilot Chat でテストする**

   - Copilot Chat（`Ctrl+Shift+I` または `Cmd+Shift+I`）を開きます。
   - 次のように質問します:「2 つの数値を足す関数を作成してください」

4-2. **応答を確認する**

期待される出力（上記の例に基づく）:
```python
def add_numbers(a: int, b: int) -> int:
    """
    2 つの数値を加算する。
    
    Args:
        a: 1 つ目の数値
        b: 2 つ目の数値
        
    Returns:
        a と b の合計値
        
    Example:
        >>> add_numbers(2, 3)
        5
    """
    return a + b
```

ポイント:
- タイプヒント（`int`）
- 説明、引数、戻り値、使用例を含む docstring
- 分かりやすいパラメーター名

### 5. 応用: スコープを限定したインストラクション

プロジェクト内の特定領域に別ルールを適用することもできます。

5-1. **スコープ付きセクションを作成する**

`copilot-instructions.md` に以下を追記します。
```markdown
---
applyTo: "tests/**"
---

# テストのガイドライン
   - Use pytest for all tests
   - Name test files with `test_` prefix
   - Use descriptive test function names
   - Include both positive and negative test cases

   - テストには pytest を使用する
   - テストファイルは `test_` プレフィックスで始める
   - テスト関数には説明的な名前を付ける
   - 正常系と異常系の両方を用意する
```

5-2. **複数のスコープブロックを併用する**

1 つのファイル内に複数の `---` セクションを記述できます。
```markdown
---
applyTo: "**"
---
# すべてのファイルに共通のガイドライン

---
applyTo: "*.py"
---
# Python 固有のガイドライン

---
applyTo: "docs/**"
---
# ドキュメント向けのガイドライン
```

### 6. カスタムインストラクションのベストプラクティス

**シンプルに保つ:**
- まずは 3〜5 件程度の基本ルールから始める
- 必要に応じてルールを追加する
- 文言は具体的で明確にする

**一貫性を持たせる:**
- チームのコーディング規約と整合させる
- 基準が変わったらすぐにファイルを更新する

**定期的にテストする:**
- Copilot がルールを守っているか確認する
- 意図通りに動かない場合は表現を調整する

**よくあるテーマ:**
- コードスタイルやフォーマット
- 命名規則
- ドキュメント要件
- エラーハンドリング
- テスト戦略
- セキュリティの考慮事項

### 7. カスタムエージェントを作成する

カスタムエージェントは、特定の開発役割やタスクに合わせて Copilot Chat をカスタマイズした再利用可能なペルソナです。カスタムインストラクションがコード生成に影響するのに対し、カスタムエージェントはチャットの応答スタイルや利用可能なツールを制御します。

> **Note:** カスタムエージェントは以前「カスタムチャットモード」と呼ばれていました。`.github/chatmodes` に既存の `.chatmode.md` ファイルがある場合でも VS Code は認識します。また、`.github/agents` フォルダーに `.agent.md` として移動・改名することもできます。

7-1. **カスタムエージェントの設定画面を開く**

   - Copilot Chat パネルを開く
   - チャットパネル上部のエージェントセレクター（ドロップダウン）をクリック
   - ドロップダウンから「Configure Custom Agents」を選択

![custom-agent](images/chat-customization/custom-agent.png)

7-2. **新しいカスタムエージェントを作成する**

   - 「Create new custom agent」をクリック、またはコマンドパレット（`Ctrl+Shift+P` / `Cmd+Shift+P`）で `Chat: New Custom Agent` を実行
   - 作成場所を選択:
     - **Workspace**: `.github/agents` フォルダーに作成（このプロジェクト専用）
     - **User profile**: ユーザープロファイル配下に作成（すべてのワークスペースで利用）
   - ファイル名（例: `code-reviewer`）を入力

![agent-path](images/chat-customization/agent-path.png)

7-3. **エージェントの名前と説明を記述する**

VS Code はテンプレート付きの `.agent.md` ファイルを作成します。
```markdown
---
description: 'Describe what this custom agent does and when to use it.'
tools: []
---
Define what this custom agent accomplishes for the user, when to use it, and the edges it won't cross. Specify its ideal inputs/outputs, the tools it may call, and how it reports progress or asks for help.
```

例:
- **description**: `Provides code review feedback instead of direct answers`

7-4. **カスタムエージェントのヘッダー項目を理解する**

YAML frontmatterにはさまざまな設定項目を追加できます。主なものを以下に示します。

**コア項目:**
- `description`: このエージェントを選択したとき、チャット入力欄のデフォルト定型文に表示される説明
- `name`: エージェントの表示名（指定しない場合はファイル名が使われる）
- `argument-hint`: ユーザーへの入力ガイドを表示する任意のヒント

**ツール設定:**
- `tools`: エージェントが利用できるツール名の配列
  - ビルトインツール: `'search'`, `'fetch'`, `'usages'`, `'edit'` など
  - MCP サーバーツール: `'<server-name>/*'` の形式でそのサーバーの全ツールを許可
  - 拡張機能が提供するツール
  - 利用できないツールが指定された場合は無視されるだけです

**高度なオプション:**
- `model`: 使用する AI モデル（例: `'Claude Sonnet 4'`）。指定がない場合は現在選択中のモデルを使用
- `target`: 対象環境（`'vscode'` または `'github-copilot'`）
- `mcp-servers`: GitHub Copilot ターゲットで使う Model Context Protocol サーバー設定
- `handoffs`: 他のエージェントへワークフローを引き継ぐ設定（詳細は 7-6 を参照）

複数項目を組み合わせた例:
```markdown
---
description: Provides code review feedback instead of direct answers
name: CodeReviewer
argument-hint: Include style guides or specific aspects to focus on
tools: ['fetch', 'githubRepo', 'search', 'usages']
model: Claude Sonnet 4
---
```

7-5. **エージェント用の指示を書く**

frontmatterの下にエージェントの振る舞いを記述します。
```markdown
You are a strict code review assistant. When the user provides code, analyze it and respond with constructive feedback on style, correctness, and best practices.

- Point out any potential bugs or inefficiencies
- Suggest improvements, but DO NOT rewrite the code unless asked
- Use bullet points for each issue
- Focus on security vulnerabilities, performance, and maintainability

あなたは厳格なコードレビューアシスタントです。ユーザーがコードを提供したら、それを分析し、スタイル、正確性、ベストプラクティスに関する建設的なフィードバックを返してください。

- 潜在的なバグや非効率な点を指摘する
- 改善案を提示するが、求められない限りコードを書き直さない
- 各問題点は箇条書きで示す
- セキュリティ脆弱性、パフォーマンス、保守性に焦点を当てる
```

- 平易で明確な言葉を使いましょう。
- 期待する振る舞いを具体的に書くと一貫性が高まります。
- `#tool:<tool-name>` 形式で利用したいツールを参照することもできます。

7-6. **ハンドオフでワークフローを連携させる（任意）**

ハンドオフを設定すると、応答後に別エージェントへの切り替えボタンが表示され、コンテキストと事前入力済みプロンプトを引き継げます。

Frontmatterに以下を追記します。
```markdown
---
description: Provides code review feedback instead of direct answers
name: CodeReviewer
argument-hint: Include style guides or specific aspects to focus on
tools: ['fetch', 'githubRepo', 'search', 'usages']
model: Claude Sonnet 4
handoffs:
  - label: Fix Issues
    agent: agent
    prompt: Fix the issues identified in the code review above.
    send: false
---
```

各フィールドの意味:
- `label`: ハンドオフボタンに表示されるテキスト
- `agent`: 切り替え先のエージェント識別子
- `prompt`: 切り替え先であらかじめ入力されるプロンプト
- `send`: `true` にするとプロンプトを自動送信（省略時は `false`）

**よくあるワークフロー例:**
- プランニング → 実装: 計画を立ててから実装エージェントに切り替える
- 実装 → レビュー: コードを生成したらレビューエージェントに渡す
- テストを書く → テストをパスするまで修正: 先にテストを作成し、その後実装エージェントに渡す

7-7. **エージェントファイルを保存する**

   - `Ctrl+S`（Windows/Linux）または `Cmd+S`（macOS）で保存します。
   - VS Code が新しいカスタムエージェントを認識し、エージェントセレクターに表示されます。

### 8. カスタムエージェントをテストする

8-1. **新しいエージェントを有効にする**

   - Copilot Chat パネルを開く
   - エージェントセレクターで作成したエージェント（例: `Code Reviewer`）を選択する

8-2. **サンプルコードをレビューさせる**

例:
```python
# Sample code to review
def add_numbers(a, b):
    result = a + b
    print("The result is", result)
    return result
```

   - このコードをチャット入力欄に貼り付け、コードブロックとして送信します。

8-3. **レビューを依頼する**

「上記のコードをレビューして、問題点や改善点があれば教えてください。」と入力し、送信します。

8-4. **レビュー結果を観察する**

期待される応答例:
- ライブラリ関数での不要な `print()` を指摘する
- docstring の追加を推奨する
- 型ヒントや入力バリデーションを提案する
- 想定外ケースへの対応不足を指摘する

8-5. **追加の質問で試す**

`Code Reviewer` エージェントを選択したまま:
- 別のコードスニペットを貼り付ける
- 「改善できる点は何ですか？」と尋ねる
- デフォルトエージェントと応答スタイルを比較する

> **注:** 目的に応じてエージェントを切り替えてみましょう。ワークスペースで作成したエージェントはチームメンバーとも共有できます。

---

### まとめ

これで GitHub Copilot のカスタマイズをマスターしました。`.github/copilot-instructions.md` にルールを定義してコード生成を制御し、Copilot Chat のカスタムエージェントで専門タスクに特化した支援を得られます。

### 次のステップ

さまざまなインストラクションやカスタムエージェントを試しながら、自分のプロジェクトに最適な運用パターンを見つけてください。
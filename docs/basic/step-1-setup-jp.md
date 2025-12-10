## ステップ 1: GitHub Copilot をセットアップする

### 概要
GitHub Copilot ハンズオンワークショップへようこそ。最初のステップでは、Visual Studio Code に GitHub Copilot（必要に応じて Copilot Chat）をインストールして有効化し、インラインサジェストが動作することを確認します。所要時間の目安は 10 分です。

### 事前条件
次のものを準備してください。

- **GitHub アカウント**（ブラウザでログイン済みであること。トライアルまたはサブスクリプション推奨。Free プランには制限あり）
- **Visual Studio Code**（バージョン 1.78 以上）
- **インターネット接続**
- **VS Code の基本操作を理解していること**（ファイルを開く、サイドバーを使う等）

### クイックフロー
1. VS Code を開く
2. GitHub Copilot 拡張機能（必要なら Chat も）をインストールする
3. サインインと認証を行う
4. Copilot が有効化されているか確認する
5. インラインサジェストを呼び出し、受け入れる
6. 受け入れ／拒否／候補切り替え操作を学ぶ
7. （任意）Copilot Chat を開く
8. 必要に応じてトラブルシュートする

---

## 詳細セットアップ手順

### 1. Visual Studio Code を開く
VS Code を起動します。Welcome ページや空のウィンドウで構いません。

> **注:** VS Code は毎月新機能や改善がリリースされます。バージョンによってスクリーンショットと UI が異なる場合があります。コア機能は同じですが、名称や配置が変更されることがあります。最近の主な変更点は次の通りです。
> 
> - **バージョン 1.106 (2025 年 10 月):** "Chat modes" が "custom agents" に名称変更され、`.github/chatmodes/*.chatmode.md` から `.github/agents/*.agent.md` に移動
> - **バージョン 1.105 (2025 年 9 月):** 複数ステップのワークフローをガイドする plan agent とハンドオフ機能を導入
> - **バージョン 1.104 (2025 年 8 月):** モデルの自動選択、ターミナルでの自動承認改善（明示的なセキュリティ同意）を追加
> 
> ドキュメントと手元のバージョンで違いを見つけた場合は、[VS Code リリースノート](https://code.visualstudio.com/updates) で該当バージョンの変更点を確認してください。


### 2. GitHub Copilot 拡張機能をインストールする
GitHub Copilot は標準的な VS Code 拡張機能として提供されています。

2-1. 拡張機能ビュー（四つの四角アイコン）を開く  
   - ショートカット: `Ctrl+Shift+X`（Windows/Linux）または `Cmd+Shift+X`（macOS）

2-2. `GitHub Copilot` を検索する  

2-3. 公式拡張機能（Publisher: GitHub）を見つけて **Install** をクリックする

![basic-install-copilot-extension](images/setup/install-extension.png)

2-4. （任意）案内が表示されたら **GitHub Copilot Chat** もインストールする（チャットパネルとコマンドを追加）  

2-5. ステータスバーに Copilot アイコン（回転または待機状態）が表示されるまで待機する 

### 3. VS Code で Copilot をセットアップする

VS Code で Copilot を使うには、GitHub Copilot サブスクリプションへのアクセスが必要です。VS Code 内から直接セットアップできます。

> まだ Copilot サブスクリプションを持っていない場合、[Copilot Free plan](https://docs.github.com/en/copilot/managing-copilot/managing-copilot-as-an-individual-subscriber/managing-copilot-free/about-github-copilot-free) に登録されます。

3-1. ステータスバーの Copilot アイコンにカーソルを合わせ、**Set up Copilot** を選択します。

![Hover over the Copilot icon in the Status Bar and select Set up Copilot.](images/setup/setup-copilot-status-bar.png)

3-2. サインイン方法を選び、指示に従います。

![Sign in to your GitHub account or use Copilot if you're already signed in.](images/setup/setup-copilot-sign-in.png)

3-3. これで VS Code で Copilot を利用できるようになります。

### 4. Copilot を有効化する（設定を確認）
通常は自動で有効化されますが、念のため確認します。

1. 設定を開く（`Ctrl+,` / `Cmd+,`）し、"Copilot" を検索
2. **Enable GitHub Copilot** にチェックが入っているか確認
3. Chat 拡張機能をインストールした場合は、Chat 設定が有効になっているか確認（初期設定で有効）

### 5. インラインサジェストを確認する
1. 新しいファイルを作成（`Ctrl+N` / `Cmd+N`）し、言語を **Python** に設定する（例: `test.py` として保存）
2. 次のように入力し始めます。

```python
# Function to multiply two numbers
def multiply(x, y):
	"""Return the product of two numbers."""
	# Copilot will likely suggest: return x * y
```

3. ゴーストテキスト（灰色の提案、例: `return x * y`）が表示されたら **Tab** で受け入れる
4. 何も表示されない場合:
   - もう少し入力する（例: コメントに `# multiply and return result` を追加）
   - `Ctrl+Enter` / `Cmd+Enter` で手動リクエスト
   - サインイン状態、ファイルサイズ、対応言語か確認
   - それでも表示されない場合は VS Code を再読み込み

無事にサジェストを受け入れられたら完了です！ 🎉

### 6. 基本的なインライン操作
サジェストとの付き合い方:

- **Accept（受け入れ）**: `Tab`（推奨）または `Enter`（単一行）
- **Reject / dismiss（拒否／閉じる）**: 入力を続ける、または `Esc`
- **Next suggestion（次の候補）**: `Alt+]`（Windows/Linux） / `Option+]`（macOS）
- **Previous suggestion（前の候補）**: `Alt+[` / `Option+[` 
- **Trigger manually（手動リクエスト）**: `Ctrl+Enter` / `Cmd+Enter`
- **Explain / refine**: Copilot Chat を利用

ゴーストテキストは採用前に必ず確認し、意図と一致しているか判断してください。


### トラブルシューティング
一般的な問題と対処方法:

| Issue | 確認事項 | 対処策 |
|-------|----------|--------|
| サジェストが表示されない | サインインしていない | `Copilot: Sign in to GitHub` を実行 |
| 灰色テキストが一瞬で消える | 連続入力で上書きした | 入力を止めるか `Ctrl/Cmd+Enter` で再リクエスト |
| サジェストが意図と違う | 文脈が不十分 | コード上部に説明コメントを追加 |
| Chat が使えない | Chat 拡張が未インストール | **GitHub Copilot Chat** をインストール |
| Rate / usage 制限 | Free プランの制約 | トライアルを開始するかサブスクリプションにアップグレード |

問題が解消しない場合: ウィンドウ再読み込み（`Ctrl+Shift+P` / `Cmd+Shift+P` → `Developer: Reload Window`）、ネットワーク／プロキシ設定、サインアウト再サインインを試してください。

---

### まとめ
これで VS Code に GitHub Copilot をセットアップし、サインインして、インラインサジェストが動作することを確認できました。今後のコーディングに Copilot を活用する準備が整いました。

### 次のステップ
[ステップ 2: GitHub Copilot Chat を使う](./step-2-simple-chat-usage.md) に進み、チャット機能、slash コマンド、Agent モードを学びましょう。

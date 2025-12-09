# AtCoder Codon Environment

![AtCoder 2025 Language Update Compliant](https://img.shields.io/badge/AtCoder-2025_Update_Compliant-green)

**Python 3.13** と **[Codon](https://github.com/exaloop/codon)** (ハイパフォーマンスPythonコンパイラ) を使用して AtCoder の問題を解くための完全な開発環境です。

**VS Code Dev Containers** で利用することを前提に設計されており、一般的な x86_64 PC から Apple Silicon (M1/M2/M3)搭載 Mac まで、一貫した環境を提供します。

> **Note**: 本環境は **AtCoder 2025年10月言語アップデート** (Python 3.13, 最新ライブラリ) に完全対応しています。

## 特徴

- **🚀 Codon コンパイラ**: Pythonを書けば、C++並みの速度で動作します。インストール・設定済みです。
- **📦 マルチアーキテクチャ対応**: Dockerイメージは `linux/amd64` (Intel/AMD) と `linux/arm64` (Apple Silicon) の両方をサポートしています。
- **🛠️ 便利なツール群**:
  - `atcoder-cli` (acc)
  - `online-judge-tools` (oj)
  - Python 3.13 & 標準ライブラリ
  - 主要な競プロライブラリ: `ac-library-python`, `numpy`, `scipy`, `networkx`, `sortedcontainers`, `more-itertools` など
- **🔒 ユーザデータの分離**: あなたのコードや設定ファイル(`user_data/`)はテンプレートから分離されているため、Privateリポジトリ等で安全に管理できます。

## 前提条件

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) または Docker Engine
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## 始め方

### 1. リポジトリのクローン

```bash
git clone https://github.com/liebe-magi/atcoder-codon.git
cd atcoder-codon
```

### 2. 環境の初期化

セットアップスクリプトを実行して、設定ファイルとコンテンツディレクトリを作成します。これにより、デフォルトのテンプレートが `user_data/` にコピーされます。

```bash
./user_setup.sh
```

> **Note**: `user_data/` ディレクトリは `.gitignore` に設定されています。このディレクトリ内で別途 `git init` などをすることで、この環境テンプレート自体は追従しつつ、自身の回答コードだけをPrivateリポジトリで管理することが可能です。

### 3. VS Code で開く

VS Code でリポジトリフォルダを開きます。「コンテナーで再度開く (Reopen in Container)」という通知が表示されたらクリックしてください。

または：
1.  `F1` (または `Cmd+Shift+P`) を押す
2.  **Dev Containers: Reopen in Container** を選択

VS Code が Docker イメージを取得し、環境を起動します。

### 4. AtCoder へのログイン (初回のみ)

CAPTCHAの導入により、通常のログインコマンド (`acc login`, `oj login`) は使用できません。代わりに、プリインストールされている **[aclogin](https://github.com/key-moon/aclogin)** ツールを使用します。

1.  **ブラウザでログイン**: ブラウザで [AtCoder](https://atcoder.jp/) にログインします。
2.  **セッションクッキーの取得**:
    - 開発者ツール (`F12`) を開きます。
    - **Application** (Firefoxなら Storage) タブ -> **Cookies** -> `https://atcoder.jp` を開きます。
    - `REVEL_SESSION` という名前のクッキーを探します。
    - その値をダブルクリックして**コピー**します。
3.  **aclogin の実行**:
    コンテナ内のターミナルで以下を実行します：
    ```bash
    aclogin
    ```
    プロンプトが表示されたら、コピーした `REVEL_SESSION` の値を貼り付けます。これにより、`acc` と `oj` の両方が認証されます。

## 使い方

### 1. コンテストディレクトリの作成

```bash
new abc300
cd abc300/a
```

### 2. コードのテスト (VS Code コマンド)

この環境には **Command Runner** が設定されており、ビルドやテストを簡単に実行できます。

- **Build**: `codon build` (現在のファイルを `a.out` にコンパイル)
- **Test**: `oj test` (`a.out` を `tests/` 内のテストケースでテスト)

これらはコマンドパレット (`Ctrl+Shift+P` -> "Run Command") から実行できますが、キーバインドを設定するとさらに便利です。

#### 推奨キーバインド設定

`keybindings.json` (Ctrl+K Ctrl+S -> キーボードショートカット (JSON) を開く) に以下を追加することをお勧めします：

```json
[
    {
        "key": "ctrl+f5",
        "command": "command-runner.run",
        "args": { "command": "codon build" }
    },
    {
        "key": "f5",
        "command": "command-runner.run",
        "args": { "command": "oj test" }
    }
]
```

### 3. 提出について (重要なお知らせ)

> [!WARNING]
> **`oj` や `acc` による自動提出は現在制限されています。**
>
> AtCoderによる攻撃対策のためのCAPTCHA導入に伴い、コマンドラインツール経由でのソースコード提出は基本的にできません。
> ブラウザから **手動で提出** してください。
>
> *※ Ratedコンテスト開催中などはCAPTCHAが一時的に無効化されツールが使える場合もありますが、保証はありません。*

### 4. Codon の手動コンパイル

```bash
# コンパイルして実行
codon run -release main.py
```

## ディレクトリ構成

- `template/`: 設定ファイルのひな形などが格納されています。
- `user_data/`: **[重要]** 実際の作業場所です。`setup.sh` によって作成されます。
    - `user_data/config/`: ツールやテンプレートの設定ファイル。
    - `user_data/contents/`: ソリューションコードが保存される場所。
- `docker/`: Dockerfile やビルド設定。

## カスタマイズについて

テンプレート (`main.py` など) をカスタマイズしたい場合は、`user_data/config/` 内のファイルを編集してください。`user_data` はあなたの管理下にあるため、自由に変更して構いません。

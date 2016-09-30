# Created by newuser for 5.0.2

# zplug
source ~/.zplug//init.zsh

# ダブルクォーテーションで囲うと良い
zplug "zsh-users/zsh-history-substring-search"

# コマンドも管理する
# グロブを受け付ける（ブレースやワイルドカードなど）
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# こんな使い方もある（他人の zshrc）
zplug "tcnksm/docker-alias", use:zshrc

# frozen タグが設定されているとアップデートされない
zplug "k4rthik/git-cal", as:command, frozen:1

# GitHub Releases からインストールする
# また、コマンドは rename-to でリネームできる
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

# oh-my-zsh をサービスと見なして、
# そこからインストールする
zplug "plugins/git",   from:oh-my-zsh

# if タグが true のときのみインストールされる
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# インストール・アップデート後に実行されるフック
# この場合は以下のような設定が別途必要
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"
    {
        make
        sudo make install
    } &>/dev/null
    "

# リビジョンロック機能を持つ
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Gist ファイルもインストールできる
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# bitbucket も
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    hook-build:"chmod 755 *.sh", \
    use:"*.sh"

# 依存管理
# "emoji-cli" は "jq" があるときにのみ読み込まれる
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# ノート: 読み込み順序を指定するなら nice タグを使いましょう

# 読み込み順序を設定する
# 例: "zsh-syntax-highlighting" は compinit の前に読み込まれる必要がある
# （10 以上は compinit 後に読み込まれるようになる）
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# ローカルプラグインも読み込める
zplug "~/.zsh", from:local

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

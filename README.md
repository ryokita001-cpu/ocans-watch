# ocans-watch

理研・横浜市大 一般公開2026（10/24）の入場登録が満席から再開されたら、ntfy でスマホに通知する。

- GitHub Actions で5分ごとに `check.sh` を実行（10/23 まで。10/24 以降は何もしない）
- 通知先 ntfy トピックは Secrets `NTFY_TOPIC`（ローカル控え: `~/.local/share/ocans-watch/ntfy_topic`）
- Mac 側にも launchd（`~/Library/LaunchAgents/com.kitaryo.ocans-watch.plist`）で3分ごとの監視あり
- 終了後はリポジトリを archive し、launchd を unload する

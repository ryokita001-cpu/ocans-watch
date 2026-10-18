# ocans-watch

> **GitHub Actions 側は停止中（2026-10-18）**: ntfy 通知が不要になったため、ワークフロー `watch` を無効化した（`gh workflow disable watch`）。再開は `gh workflow enable watch`。コード・Secrets `NTFY_TOPIC`・ローカルの控えは残してある。Mac 側の launchd 監視は、この時点では止めていない（下記）。以下は稼働時の仕様。

理研・横浜市大 一般公開2026（10/24）の入場登録が満席から再開されたら、ntfy でスマホに通知する。

- GitHub Actions で5分ごとに `check.sh` を実行（10/23 まで。10/24 以降は何もしない）
- 通知先 ntfy トピックは Secrets `NTFY_TOPIC`（ローカル控え: `~/.local/share/ocans-watch/ntfy_topic`）
- Mac 側にも launchd（`~/Library/LaunchAgents/com.kitaryo.ocans-watch.plist`）で3分ごとの監視あり
- 10/24 以降の最初の Mac 側チェックで `~/.local/share/ocans-watch/cleanup.sh` が自動実行され、リポジトリ archive・ローカルクローン削除・launchd 解除まで行う

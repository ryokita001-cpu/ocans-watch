# ocans-watch

> **停止中（2026-10-18）**: ntfy 通知が不要になったため、GitHub Actions のワークフロー `watch` を無効化し（`gh workflow disable watch`）、Mac 側の launchd も解除して無効化した（`launchctl bootout gui/$(id -u)/com.kitaryo.ocans-watch` に加えて `launchctl disable gui/$(id -u)/com.kitaryo.ocans-watch`。bootout だけだとログイン・再起動で plist から再登録されて動き続ける）。再開は `gh workflow enable watch` と `launchctl enable gui/$(id -u)/com.kitaryo.ocans-watch && launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.kitaryo.ocans-watch.plist`。コード・Secrets `NTFY_TOPIC`・plist・ローカルの控えは残してある。launchd を解除したため、10/24 以降の `cleanup.sh` による自動片付け（archive・クローン削除）は走らない。以下は稼働時の仕様。

理研・横浜市大 一般公開2026（10/24）の入場登録が満席から再開されたら、ntfy でスマホに通知する。

- GitHub Actions で5分ごとに `check.sh` を実行（10/23 まで。10/24 以降は何もしない）
- 通知先 ntfy トピックは Secrets `NTFY_TOPIC`（ローカル控え: `~/.local/share/ocans-watch/ntfy_topic`）
- Mac 側にも launchd（`~/Library/LaunchAgents/com.kitaryo.ocans-watch.plist`）で3分ごとの監視あり
- 10/24 以降の最初の Mac 側チェックで `~/.local/share/ocans-watch/cleanup.sh` が自動実行され、リポジトリ archive・ローカルクローン削除・launchd 解除まで行う

#!/bin/bash
# 理研・横浜市大 一般公開2026 入場登録の空き監視
# 使い方: NTFY_TOPIC=xxx STATE_FILE=path ./check.sh
URL='https://www.ocans.jp/openday-tsurumi/entry/all?FID=uyEGjrCP'
STATE_FILE="${STATE_FILE:-state}"

[ "$(TZ=Asia/Tokyo date +%Y%m%d)" -gt 20261024 ] && { echo "event over"; exit 0; }

html=$(curl -sL --max-time 30 -A 'Mozilla/5.0' "$URL") || { echo "fetch error"; exit 0; }
li=$(printf '%s' "$html" | grep -m1 'id="event-li-015001"')
[ -z "$li" ] && { echo "unknown (page changed?)"; exit 0; }

if printf '%s' "$li" | grep -q 'end-sheet'; then status=full; else status=open; fi
prev=$(cat "$STATE_FILE" 2>/dev/null)
echo "$status" > "$STATE_FILE"
echo "$(TZ=Asia/Tokyo date '+%F %T') $status (prev: ${prev:-none})"

if [ "$status" = open ] && [ "$prev" != open ] && [ -n "$NTFY_TOPIC" ]; then
  curl -s -H "Title: Riken openday: slot available" -H "Priority: urgent" -H "Tags: rotating_light" \
    -H "Click: $URL" -H "Actions: view, 今すぐ申し込む, $URL" -d "理研 一般公開(10/24)の入場登録に空きが出ました！すぐ申し込んでください
$URL" \
    "https://ntfy.sh/$NTFY_TOPIC" > /dev/null
fi

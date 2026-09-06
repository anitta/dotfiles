-- ~/.hammerspoon/init.lua
--
-- Command キーの2度押しで Alacritty (herdr) の表示/非表示をトグルする。
--
-- 修飾キー単独のタップは hs.hotkey では拾えないため、flagsChanged を
-- eventtap で監視して「単独で押して離した」ことを自前で判定する。
-- 誤爆を避けるための条件は 3 つ:
--   1. cmd 押下中に他のキー入力・クリック・スクロールが無いこと (Cmd+C 等を除外)
--   2. 他の修飾キーと同時押しでないこと
--   3. 押しっぱなしでないこと (MAX_HOLD 以内に離すこと)

require("hs.ipc") -- `hs -c ...` で外から状態を確認できるようにする

-- eventtap / pathwatcher は Lua 側から参照が切れると GC で回収され、監視が
-- 黙って止まる。Hammerspoon は init.lua の戻り値を保持しないので、
-- ローカル変数に束ねるだけでは不十分。グローバルに置いて生存させる。
AlacrittyToggle = AlacrittyToggle or {}
local M = AlacrittyToggle

-- 再読み込み時に古い監視が二重で走らないように畳む
for _, key in ipairs({ "interferenceWatcher", "cmdWatcher", "configWatcher" }) do
  if M[key] then
    M[key]:stop()
    M[key] = nil
  end
end

local TARGET_BUNDLE_ID = "org.alacritty"
local DOUBLE_TAP_INTERVAL = 0.3 -- 2度目のタップまでの猶予 (秒)
local MAX_HOLD = 0.4 -- これより長く押していたらタップとみなさない (秒)

local LEFT_CMD, RIGHT_CMD = 55, 54

local cmdDownAt = nil -- cmd を押し下げた時刻
local cmdIsClean = false -- cmd 押下中に他の入力が無いか
local lastTapAt = 0 -- 直前に成立した単独タップの時刻

hs.window.animationDuration = 0
hs.autoLaunch(true) -- ホットキーを常時効かせるためログイン時に起動する

local function resetTapState()
  cmdIsClean = false
  lastTapAt = 0
end

local function toggleTarget()
  local app = hs.application.get(TARGET_BUNDLE_ID)
  if app and app:isFrontmost() then
    app:hide()
  else
    -- 未起動なら起動、隠れているなら前面へ
    hs.application.launchOrFocusByBundleID(TARGET_BUNDLE_ID)
  end
end

-- cmd を押している間に他の入力があれば「単独タップ」を取り消す
M.interferenceWatcher = hs.eventtap.new({
  hs.eventtap.event.types.keyDown,
  hs.eventtap.event.types.leftMouseDown,
  hs.eventtap.event.types.rightMouseDown,
  hs.eventtap.event.types.otherMouseDown,
  hs.eventtap.event.types.scrollWheel,
}, function()
  resetTapState()
  return false -- イベントは握りつぶさない
end)

M.cmdWatcher = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
  local keyCode = event:getKeyCode()
  if keyCode ~= LEFT_CMD and keyCode ~= RIGHT_CMD then
    resetTapState() -- cmd 以外の修飾キーが動いたら仕切り直し
    return false
  end

  local flags = event:getFlags()

  if flags.cmd then -- 押し下げ
    cmdDownAt = hs.timer.secondsSinceEpoch()
    cmdIsClean = not (flags.alt or flags.ctrl or flags.shift or flags.fn)
    return false
  end

  -- 解放
  local wasClean = cmdIsClean and cmdDownAt ~= nil
  cmdIsClean = false

  local now = hs.timer.secondsSinceEpoch()
  if not wasClean or (now - cmdDownAt) > MAX_HOLD then
    lastTapAt = 0
    return false
  end

  if (now - lastTapAt) <= DOUBLE_TAP_INTERVAL then
    lastTapAt = 0
    toggleTarget()
  else
    lastTapAt = now
  end
  return false
end)

-- init.lua を編集したら自動で読み直す
M.configWatcher = hs.pathwatcher.new(hs.configdir, function(files)
  for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" then
      hs.reload()
      return
    end
  end
end)

M.interferenceWatcher:start()
M.cmdWatcher:start()
M.configWatcher:start()

if hs.accessibilityState() then
  hs.alert.show("Hammerspoon: ⌘⌘ → Alacritty")
else
  -- 権限付与直後は AXIsProcessTrusted の結果がプロセス内にキャッシュされたままで
  -- false を返すことがある。eventtap 自体は動いている場合もあるので文言を分ける。
  hs.alert.show("Hammerspoon: ⌘⌘ → Alacritty (要アクセシビリティ権限 / 未反映なら再起動)")
end

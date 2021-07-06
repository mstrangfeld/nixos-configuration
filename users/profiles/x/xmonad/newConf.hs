------------------------------------------------------------------------
-- IMPORTS
------------------------------------------------------------------------
import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig (additionalKeysP)

------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------

-- XMonad
myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 3

-- Colors
data Colorscheme = Colorscheme
  { foreground :: String,
    background :: String
  }

colors :: Colorscheme
colors = Colorscheme "#1681f2" "#dddddd"

-- Applications
myTerminal :: [Char]
myTerminal = "alacritty"

appLauncher :: [Char]
appLauncher = "rofi -modi drun -show drun -show-icons"

screenLocker :: [Char]
screenLocker = "multilockscreen -l dim"

screenshotTool :: [Char]
screenshotTool = "flameshot full -p ~/Pictures/screenshot/"

-- Workspaces
myWS :: [WorkspaceId]
myWS = ["dev", "web", "chat", "media", "sys", "etc"]

------------------------------------------------------------------------
-- MAIN
------------------------------------------------------------------------
main :: IO ()
main =
  xmonad . ewmh $
    def
      { modMask = myModMask,
        terminal = myTerminal,
        focusFollowsMouse = False,
        clickJustFocuses = False,
        borderWidth = myBorderWidth,
        normalBorderColor = background colors,
        focusedBorderColor = foreground colors,
        handleEventHook = handleEventHook def <+> fullscreenEventHook
      }
      `additionalKeysP` myKeys

------------------------------------------------------------------------
-- KEYBINDINGS
------------------------------------------------------------------------
myKeys :: [(String, X ())]
myKeys =
  [ -- Applications
    ("M-S-<Return>", spawn myTerminal), -- Start terminal
    ("M-p", spawn appLauncher), -- Start applauncher
    ("M-C-l", spawn screenLocker), -- Start lockscreen
    -- Media
    ("M-<Print>", spawn screenshotTool), -- Take Screenshot
    -- Layouts
    ("M-<Space>", sendMessage NextLayout), -- Next layout
    ("M-S-<Space>", setLayout (XMonad.layoutHook conf)),
    -- Polybar
    ("M-C-p", togglePolybar) -- Toggle polybar
  ]
  where
    togglePolybar = spawn "polybar-msg cmd toggle &"

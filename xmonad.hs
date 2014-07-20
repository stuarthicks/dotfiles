{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}
import XMonad
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog

main = xmonad =<< xmobar defaultConfig
  {
    terminal = "gnome-terminal",
    modMask = mod4Mask,
    borderWidth = 1,
    layoutHook = smartSpacing 5 $ Tall 1 (3/100) (1/2)
  }

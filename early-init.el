;;; early-init.el --- Pre-startup configuration -*- lexical-binding: t; -*-

;; Emacs 27+ loads `early-init.el' BEFORE the GUI is initialized and
;; BEFORE `package-initialize' runs.  Settings that need to take
;; effect during startup (GC, native-comp, frame chrome, package
;; system) belong here, not in `configuration.org', which is only
;; tangled and loaded from `init.el' AFTER the initial frame is drawn.

;;; Garbage collection
;; A high threshold during startup avoids dozens of mid-init GCs and
;; measurably cuts launch time.  `gcmh' (loaded from configuration.org)
;; takes over adaptive management once Emacs is idle.
(setq gc-cons-threshold (* 256 1024 1024)
      gc-cons-percentage 0.6
      inhibit-compacting-font-caches t)

;;; Native compilation
(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors 'silent)

;;; Package system
;; `package-initialize' is called by Emacs automatically before
;; `init.el' loads when this is non-nil.  Keeping it on so that
;; configuration.org doesn't need to re-initialize.
(setq package-enable-at-startup t)

;;; Frame chrome
;; Disable bars BEFORE the first frame is drawn -- avoids the visible
;; flicker that happens when these are turned off later in init.
(setq frame-inhibit-implied-resize t)

(push '(menu-bar-lines . 0)     default-frame-alist)
(push '(tool-bar-lines . 0)     default-frame-alist)
(push '(vertical-scroll-bars)   default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

(when (eq system-type 'gnu/linux)
  (push '(undecorated . t) default-frame-alist))

;;; early-init.el ends here

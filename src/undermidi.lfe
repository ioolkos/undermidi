(defmodule undermidi
  (export
   (start 0))
  (export
   (ping 0)
   (example 0)
   (send 1)
   (stop-port 0)
   (version 0)
   (version-go-midi-server 0)
   (versions 0)))

(include-lib "logjam/include/logjam.hrl")

(defun start ()
  (logger:set_primary_config #m(level all))
  (logjam:set-handler-from-config "config/sys.config")
  (log-notice "Starting undermidi application ...")
  (application:ensure_all_started 'undermidi))

;;; Aliases

(defun ping ()
  (undermidi.go.server:send #(command ping)))

(defun example ()
  (undermidi.go.server:send #(command example)))

(defun send (msg)
  (undermidi.go.server:send msg))

(defun stop-port ()
  (undermidi.go.server:send #(command stop)))

(defun version ()
  (undermidi.util:version))

(defun version-go-midi-server ()
  (undermidi.go.server:send #(command version)))

(defun versions ()
  (let ((`#(result ,go-app-vsn) (version-go-midi-server)))
    (++ (undermidi.util:versions)
        `(#(midiserver ,go-app-vsn)))))

(defpackage #:reblocks-ui/ci
  (:use #:cl)
  (:import-from #:40ants-ci/jobs/linter
                #:linter)
  (:import-from #:40ants-ci/jobs/run-tests
                #:run-tests)
  (:import-from #:40ants-ci/jobs/docs
                #:build-docs)
  (:import-from #:40ants-ci/workflow
                #:defworkflow)
  (:import-from #:40ants-ci/jobs/critic
                #:critic))
(in-package reblocks-ui/ci)


(defworkflow docs
  :on-push-to "master"
  :on-pull-request t
  :cache t
  :jobs ((build-docs :asdf-system "reblocks-ui-docs")))


(defworkflow ci
  :on-push-to "master"
  :by-cron "0 10 * * 1"
  :on-pull-request t
  :cache t
  :jobs ((linter)
         (critic :ignore-criticues
                 ;; Seems Lisp Critic counts docstring lines too :(
                 ("function-too-long"))
         ;; (run-tests :coverage t)
         ))

{ blockTypes }:
with blockTypes; [
  (functions "ci-condition")
  (runnables "ci-job")
  (functions "ci-schedule")
  (runnables "hydraJobs")

  (functions "errors")
  (functions "flake-check")
  (namaka "namaka")
  (nixostests "nixosTests")
]

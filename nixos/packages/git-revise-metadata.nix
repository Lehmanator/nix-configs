{ git
, lib
, writeShellApplication
, stdenv
}:
#
# Shell script to quickly revise the author/commit date of a Git commit. 
#
# TODO: Handle 2 args => GIT_AUTHOR_DATE = GIT_COMMITTER_DATE
# TODO: Handle 3 args => GIT_AUTHOR_DATE = $2, GIT_COMMITTER_DATE = $3
# TODO: Handle multiple commits
# TODO: Handle relative timestamps
#
writeShellApplication {
  name = "git-revise-commit-metadata";
  runtimeInputs = [git];
  text = ''
    COMMIT="${1}"
    RELTIME_AUTHOR="$2"
    if [[ $# -gt 2 ]]; then
      RELTIME_COMMIT="$3"
    else
      RELTIME_COMMIT="$2"
    fi
    
    if [[ $# -eq 3 ]]; then
      GIT_COMMITTER_DATE="$(date --date=$RELTIME_COMMIT)"
    else
      GIT_COMMITTER_DATE="$(date --date=$RELTIME_AUTHOR)"
    fi
    # To change the date of an existing commit:
    git filter-branch --env-filter \
      'if [ $GIT_COMMIT = "$COMMIT" ]
       then
         export GIT_COMMITTER_DATE="$(date --date=$RELTIME_COMMIT)"
         export GIT_AUTHOR_DATE="$(date --date=$RELTIME_AUTHOR)"
       fi'
  '';
}

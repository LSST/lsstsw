#!/bin/bash

set -Eeo pipefail

expect() {
  local title="$1"
  local is="$2"
  local should="$3"

  echo -e "$title"

  if [[ "$is" != "$should" ]]; then
     echo -e "    expected(${should})"
     echo -e "    got(${is})"
     exit 1
  fi
}

case $MODE in
deploy*)
  # print git version
  git --version
  if [[ $MODE == deploy3-bleed ]]; then
    echo -e "*** testing with BLEED Python 3 conda/pip packages ***"
    ./bin/deploy -b
  elif [[ $MODE == deploy3 ]]; then
    echo -e "*** testing with PINNED Python 3 conda/pip packages ***"
    ./bin/deploy
  else
    echo -e "*** Unrecognized mode for deploy script ***" >&2
    exit 1
  fi
  # shellcheck disable=SC1091
  . ./bin/setup.sh
  case $(uname -s) in
    Linux*)
      conda_packages="conda3_packages-linux-64.txt"
      ;;
    Darwin*)
      conda_packages="conda3_packages-osx-64.txt"
      ;;
    *)
      echo "unsupported platform $(uname -s)"
      exit 1
      ;;
  esac
  echo -e "*** checking installed vs ${conda_packages} conda packages ***"
  conda list -e > "./etc/${conda_packages}"
  git --no-pager diff
  rebuild pytest
  ;;
versiondb*)
  echo -e "*** testing VERSIONDB_PUSH=$VERSIONDB_PUSH for versiondb ***"
  export VERSIONDB_PUSH
  export VERSIONDB_REPO=./versiondb-test
  mkdir -p $VERSIONDB_REPO
  (cd $VERSIONDB_REPO; git init --bare)
  # pull will fail unless there is a master ref to actually pull; so we
  # make one
  (
    tmpdir=$(mktemp -u -t 'versiondb.XXXXXXXX')
    # shellcheck disable=SC2064
    trap "{ rm -rf $tmpdir; }" EXIT

    mkdir -p "$tmpdir"
    git clone "$VERSIONDB_REPO" "$tmpdir"
    cd "$tmpdir"
    # it appears that with some versions of git, --author doesn't bypass
    # the user.email/user.name check.
    git config --local user.email 'author@example.com'
    git config --local user.name 'A U Thor'
    git commit --allow-empty -m 'initial commit' --author='A U Thor <author@example.com>'
    git push origin master
  )

  ./bin/deploy

  mkdir -p versiondb/{dep_db,ver_db,manifests}

  # shellcheck disable=SC1091
  . ./bin/setup.sh
  rebuild pytest

  cd $VERSIONDB_REPO
  if [[ $VERSIONDB_PUSH == true ]]; then
    echo 'should have master ref'
    git show-ref --heads | grep -q refs/heads/master

    mapfile -t revs < <(git rev-list master)

    # the first commit is the garbage empty commit in order to create the
    # master ref
    expect 'should have two commits' \
      "${#revs[@]}" \
      2

    expect 'should have author name' \
      "$(git log --format=%an "${revs[0]}"^\!)" \
      'LSST DATA Management'

    expect 'should have author email' \
      "$(git log --format=%ae "${revs[0]}"^\!)" \
      'dm-devel@lists.lsst.org'

    expect 'should have subject line' \
      "$(git log --format=%s "${revs[0]}"^\!)" \
      'Updates for build b1.'
  else
    echo 'should have master ref'
    git show-ref --heads | grep -q refs/heads/master

    mapfile -t revs < <(git rev-list master)
    expect 'should have one commit' \
      ${#revs[@]} \
      1
  fi
  ;;
redeploy)
  ./bin/deploy

  set -x
  echo 'check lsst_build update works when a hash is specified'
  current_hash=$(cd lsst_build; git log -n 1 --pretty=format:'%H')
  LSST_BUILD_GITREV="$current_hash" ./bin/deploy

  echo 'check lsst_build update works when a branch name is specified'
  LSST_BUILD_GITREV='master' ./bin/deploy
  set +x
  ;;
*)
  echo "unknown MODE: $MODE"
  exit 1
  ;;
esac

# vim: tabstop=2 shiftwidth=2 expandtab

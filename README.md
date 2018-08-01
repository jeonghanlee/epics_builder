# epics_builder

EPICS Building Environment, works with epics_manifest [1] and Repo [2].


## Preparation

One needs to setup Repo as follows:

```
$ mkdir -p ~/bin
$ export PATH=~/bin:$PATH
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
$ chmod a+x ~/bin/repo
```


## Procedure

### Step 1:  Create a directory
```
$ mkdir epics_env
$ cd epics_env
```

### Step 2: Init


* Initialize epics_env to use the default.xml [3] on the master branch

```
epics_env $ repo init -u https://github.com/jeonghanlee/epics_manifest.git
```

### Step 3: Sync

```
epics_env $ repo sync --no-clone-bundle
```


### Step 4: Build


```
epics_env $ bash pkg.bash
epics_env $ make init
epics_env $ make base
epics_env $ make modules
```

### Step 5: Set the EPICS environment
```
epics_env $ source setEpicsEnv.bash
```


## Additional commands

* Initialize epics_env to use the epics_1808.xml, on the master branch
```
repo init -u https://github.com/jeonghanlee/epics_manifest.git -m epics_1808.xml
```

* Force Sync
```
repo sync --force-sync --no-clone-bundle
```

## References and comments

[1] https://github.com/jeonghanlee/epics_manifest
[2] https://gerrit.googlesource.com/git-repo/
[3] default.xml is the symbolic link to epics_1808.xml



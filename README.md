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


## EPICS Extensions 

One can install the additional EPICS extensions such as medm and Striptool with epics_180802.xml manifest. Please see the Additional commands. 

```
epics_env $ make init-exts
epics_env $ make exts
```
Step 5 in the above Procedure, also has the extension path.


## AreaDetector

One can also install few predefined and selected Area Detector and its Plugin. Note that it will clone all plugin in a local directory even if few selected one will be installed. 

```
ADCore
ADSupport
ADSIMDETECTOR
ADCSIMDETECTOR
ADPOINTGREY
ADANDOR
ADANDOR3
ADPROSILICA
NDDRIVERSTDARRAYS
PVADRIVER
ADURL
```
And it also enable the following epics modules as:

```
ASYN
AUTOSAVE
BUSY
CALC
SNCSEQ
DEVIOCSTATS
SSCAN
```

```
epics_env $ make init-ad
epics_env $ make ad
```


## VisualDCT

One can install VisualDCT in EPICS_EXTENSIONS. If one would like to do, please run ```installVisualDCT```.


## Platform Path
In the directory, one can find the following additional tools which allow users to install few more enviornment or libraries. For further information, please look at corresponding url

### ethercat
* https://github.com/icshwi/etherlabmaster

### lmfit
* https://github.com/jeonghanlee/lmfit-env

### opencv
* https://github.com/jeonghanlee/opencv-env

### nioc
* https://github.com/jeonghanlee/epics_NIOCs



## Additional commands

* Initialize epics_env to use the epics_180811.xml, on the master branch
```
repo init -u https://github.com/jeonghanlee/epics_manifest.git -m epics_180811.xml
```

* Force Sync
```
repo sync --force-sync --no-clone-bundle
```

## References and comments

(1) https://github.com/jeonghanlee/epics_manifest
(2) https://gerrit.googlesource.com/git-repo/
(3) default.xml is the symbolic link



[1]: https://github.com/jeonghanlee/epics_manifest
[2]: https://gerrit.googlesource.com/git-repo/   
[3]: default.xml is the symbolic link



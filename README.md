[![Build Status](https://travis-ci.org/jhidalgocarrio/image_analysis-exercise.svg?branch=master)](https://travis-ci.org/jhidalgocarrio/image_analysis-exercise)

# Event-aided Direct Sparse Odometry

[![Direct Sparse Odometry](https://rpg.ifi.uzh.ch/eds/eds_all_characters_crop_youtube.png)](https://youtu.be/W0ho2FQmggU)

This is the code for the paper [**Event-aided Direct Sparse Odometry**](http://rpg.ifi.uzh.ch/docs/CVPR22_Hidalgo.pdf) by
[Javier Hidalgo-Carrió](https://jhidalgocarrio.github.io), [Guillermo Callego](https://sites.google.com/view/guillermogallego), and [Davide
Scaramuzza](http://rpg.ifi.uzh.ch/people_scaramuzza.html):

If you use this work in your research, please cite the following paper:

```bibtex
@Article{Hidalgo2022cvpr,
  author = {Hidalgo-Carri{\'{o}}, Javier and Gallego, Guillermo and Scaramuzza, Davide},
  title = {Event-aided Direct Sparse odometry},
  journal = {IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
  year = {2022}
}
```

License
-------
This source code is GPLv3 license. See the LICENSE file for further details.

Installation
-------

1. Make sure that the Ruby interpreter is installed on your machine. Rock requires ruby 2.3 or higher, which is provided on Debian and Ubuntu by the ruby2.3 package.  This is tested with Ruby 2.7 on a Ubuntu 20.04

2. Create and “cd” into the directory in which you want to install the toolchain.
```console
docker@~S mkdir rock && cd rock && mkdir dev && cd dev
docker@dev:~$ pwd
/home/javi/rock/dev
```
3. To build EDS, use this bootstrap.sh script. Save it in the folder you just created.

```console
docker@dev:~$ wget https://raw.githubusercontent.com/uzh-rpg/eds-buildconf/master/bootstrap.sh
```
4. In a console run
```console
docker@dev:~$ sh bootstrap.sh
```
5. Follow the installation guide and answer the questions. In case you hesitate choose the answer by default.

6. Answer here 'true' in case you want to activate python. You need a python installation in your system for this.

6. Select 'master' in case you want to build EDS with DSO backend or choose 'ceres' otherwise



Dockerfile and Image
-------
All the steps described in Installation are in the Dockerfile. 


Execution
-------
<p align="left">
  <a href="https://rpg.ifi.uzh.ch/eds.html">
    <img src="./doc/img/monitor_eds.png" alt="EDS" width="640"/>
  </a>
</p>

The Event-to-Image Tracker: Source Code
-------
EDS adds Events to direct methods. You could simply have a look at this zip file, in case you are already familizised with direct methods and you just want to see the core source code of the event-based tracker that implement EDS. The code in the zip file contains comments to the equations in the [paper](http://rpg.ifi.uzh.ch/docs/CVPR22_Hidalgo.pdf).

EDS source code is structure as follows:

* [buildconf](https://github.com/uzh-rpg/eds-buildconf): is this reposity where the bootstrapping mechanism to install EDS is located.
* [bundles/eds](https://github.com/uzh-rpg/bundles-eds): this is the bundles. Bundles are collections of all files needed to run a particular system. Those are configuration files, calibration files and script files for executing the binaries.
* [slam/eds](https://github.com/uzh-rpg/slam-eds): this is the EDS C++ library.
* [slam/orogen/eds](https://github.com/uzh-rpg/bundles-orogen-eds): this is the Task that builds a class with all the system's functionalities.


Acknowledgements
-------
The Authors would like to thank [Simon Klenk](https://vision.in.tum.de/members/klenk) from TUM for the nice discussions about the potential of direct methods. We also thank our collaboration with [Prophesee](https://www.prophesee.ai) and Huawei.
